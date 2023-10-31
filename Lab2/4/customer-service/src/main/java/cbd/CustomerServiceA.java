package cbd;
 
import java.util.Arrays;

import org.bson.Document;

import com.mongodb.ConnectionString;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class CustomerServiceA {
    private static final int MAX_PRODUCTS_PER_USER = 30;
    private static final int TIME_SLOT_IN_SECONDS = 3600;

    private ConnectionString connectionString;
    private MongoClient mongoClient;
    private MongoDatabase cbdDatabase;
    private MongoCollection<Document> customerServiceCollection;

    public CustomerServiceA() {
        this.connectionString = new ConnectionString(
                "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.10.6");
        this.mongoClient = MongoClients.create(connectionString);
        this.cbdDatabase = mongoClient.getDatabase("cbd");
        if (cbdDatabase.getCollection("customerServiceA") != null) {
            cbdDatabase.getCollection("customerServiceA").drop();
        }
        this.cbdDatabase.createCollection("customerServiceA");
        this.customerServiceCollection = cbdDatabase.getCollection("customerServiceA");
    }


    public boolean requestProduct(String username, String product) {
        Document userData = customerServiceCollection.find(Filters.eq("username", username)).first();
        long currentTime = System.currentTimeMillis() / 1000;
        int requestCount;
        long firstRequestTime;
        if (userData != null) {
            requestCount = userData.getInteger("request_count");
            firstRequestTime = userData.getLong("first_request_time");
        } else {
            requestCount = 0;
            firstRequestTime = currentTime;
        }
        if (currentTime - firstRequestTime >= TIME_SLOT_IN_SECONDS) {
            requestCount = 0;
        }
        if (requestCount >= MAX_PRODUCTS_PER_USER) {
            return false;
        }
        Document newUserData = new Document("username", username)
            .append("request_count", requestCount + 1)
            .append("first_request_time", firstRequestTime);
        if (customerServiceCollection.find(Filters.eq("username", username)).first() == null)
            customerServiceCollection.insertOne(newUserData);
        else
            customerServiceCollection.updateOne(Filters.eq("username", username), new Document("$set", newUserData));
        customerServiceCollection.updateOne(Filters.eq("username", username), new Document("$push", new Document("requests", product)));
        return true;
    }


    public void close() {
        this.mongoClient.close();
    }
     
    public static void main(String[] args) {
        CustomerServiceA customerService = new CustomerServiceA();
        
        String username = "ricardo";
        String product = "product";
        for (int i = 0; i < 32; i++) {
            boolean allowed = customerService.requestProduct(username, product + String.valueOf(i));
            System.out.print("Product number: " + String.valueOf(i + 1) + ". ");
            if (allowed) {
                System.out.println("Request accepted.");
            } else {
                System.out.println("Request rejected: Exceeded limit.");
            }
        }

        customerService.close();
    }
}
