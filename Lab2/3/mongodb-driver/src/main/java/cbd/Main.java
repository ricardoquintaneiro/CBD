package cbd;

import static com.mongodb.client.model.Sorts.ascending;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.ConnectionString;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class Main {
    public static void main(String[] args) {
        ConnectionString connectionString = new ConnectionString("mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.10.6");
        MongoClient mongoClient = MongoClients.create(connectionString);
        MongoDatabase cbdDatabase = mongoClient.getDatabase("cbd");
        MongoCollection<Document> restaurantesCollection = cbdDatabase.getCollection("restaurants");

        Bson filter = Filters.and(Filters.in("localidade", "Bronx"), Filters.gt("grades.score", 65));
        restaurantesCollection.find(filter).sort(ascending("nome")).forEach(doc -> System.out.println(doc.toJson()));

        // TODO Não usar new Document para Arrays!
        Document newRestaurant = new Document("nome", "Café do Ric")
            .append("localidade", "Vagos")
            .append("grades", new Document("score", 100).append("date", "2023-10-19T00:00:00Z"))
            .append("cuisine", "Portuguese")
            .append("restaurant_id", "999999999")
            .append("address", new Document("building", "1")
                .append("street", "Rua do Ric")
                .append("zipcode", "3840-000")
                .append("coord", new Document("lat", 40.0).append("long", 50.0)));
        restaurantesCollection.insertOne(newRestaurant);
        
        mongoClient.close();
    }
}