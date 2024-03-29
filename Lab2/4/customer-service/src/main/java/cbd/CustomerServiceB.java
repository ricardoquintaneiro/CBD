package cbd;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

import org.bson.Document;

import com.mongodb.ConnectionString;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class CustomerServiceB {
    private static final int MAX_UNITS_PER_PRODUCT = 30;
    private static final int TIME_SLOT_IN_SECONDS = 3600;

    private ConnectionString connectionString;
    private MongoClient mongoClient;
    private MongoDatabase cbdDatabase;
    private MongoCollection<Document> customerServiceCollection;

    public CustomerServiceB() {
        this.connectionString = new ConnectionString(
                "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.10.6");
        this.mongoClient = MongoClients.create(connectionString);
        this.cbdDatabase = mongoClient.getDatabase("cbd");
        // if (cbdDatabase.getCollection("customerServiceB") != null) {
            // cbdDatabase.getCollection("customerServiceB").drop();
        // }
        this.cbdDatabase.createCollection("customerServiceB");
        this.customerServiceCollection = cbdDatabase.getCollection("customerServiceB");
    }

    public boolean requestProduct(String username, String product, int units) {
        Document userData = customerServiceCollection.find(Filters.eq("username", username)).first();
        long currentTime = System.currentTimeMillis() / 1000;
        int productCount = 0;
        long firstRequestTime = currentTime;
        if (userData != null) {
            firstRequestTime = userData.getLong("first_request_time");
            Document requests = userData.get("requests", Document.class);
            if (requests != null && requests.containsKey(product)) {
                productCount = requests.getInteger(product);
            }
        }
        if (currentTime - firstRequestTime >= TIME_SLOT_IN_SECONDS) {
            firstRequestTime = currentTime;
            productCount = 0;
        }
        if (productCount + units > MAX_UNITS_PER_PRODUCT)
            return false;
        Map<String, Integer> newProductAndCount = new HashMap<>();
        newProductAndCount.put(product, productCount + units);
        Document newUserData = new Document("username", username)
                .append("first_request_time", firstRequestTime);
        if (userData != null) {
            Document update;
            if (userData.containsKey("requests")) {
                Document updateOperation = new Document("requests." + product, productCount + units);
                update = new Document("$set", updateOperation);
            } else {
                Document updateOperation = new Document("requests", new Document(product, productCount + units));
                update = new Document("$set", updateOperation);
            }
            customerServiceCollection.updateOne(Filters.eq("username", username), update);
        } else {
            newUserData.append("requests", new Document(product, productCount + units));
            customerServiceCollection.insertOne(newUserData);
        }
        return true;
    }

    public void clearAllRequests(String username) {
    Document userData = customerServiceCollection.find(Filters.eq("username", username)).first();
    if (userData != null) {
        Document updatedUserData = new Document(userData);
        updatedUserData.put("requests", new Document());
        customerServiceCollection.replaceOne(Filters.eq("username", username), updatedUserData);
    }
    }

    public void close() {
        this.mongoClient.close();
    }

    public static void main(String[] args) {
        CustomerServiceB customerService = new CustomerServiceB();
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your username: ");
        String username = scanner.nextLine();
        while (true) {
            System.out.println("\nOptions:");
            System.out.println("1. Make a request");
            System.out.println("2. Clear all requests");
            System.out.println("3. Exit");
            System.out.print("Enter your choice (1/2/3): ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            switch (choice) {
                case 1:
                    System.out.print("Enter the product name: ");
                    String product = scanner.nextLine();
                    System.out.print("Enter the number of units: ");
                    int units = scanner.nextInt();
                    scanner.nextLine();
                    boolean allowed = customerService.requestProduct(username, product, units);
                    if (allowed) {
                        System.out.println("\nRequest accepted.");
                    } else {
                        System.out.println("\nRequest rejected: Exceeded limit!");
                    }
                    break;
                case 2:
                    customerService.clearAllRequests(username);
                    System.out.println("\nAll requests cleared.");
                    break;
                case 3:
                    System.out.println("\nExiting Customer Service.");
                    scanner.close();
                    customerService.close();
                    System.exit(0);
                default:
                    System.out.println("Invalid choice. Please select 1, 2, or 3.");
            }
        }
    }
}
