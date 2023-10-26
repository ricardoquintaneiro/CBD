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
import com.mongodb.client.model.Indexes;

public class B {
    public static void main(String[] args) {
        ConnectionString connectionString = new ConnectionString(
                "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.10.6");
        MongoClient mongoClient = MongoClients.create(connectionString);
        MongoDatabase cbdDatabase = mongoClient.getDatabase("cbd");
        MongoCollection<Document> restaurantesCollection = cbdDatabase.getCollection("restaurants");

        restaurantesCollection.dropIndexes();

        long startTime = System.nanoTime();
        Bson filter = Filters.and(Filters.eq("localidade", "Bronx"), Filters.eq("gastronomia", "Mexican"), Filters.eq("nome", "Vista Hermosa Deli Restaurant"));
        restaurantesCollection.find(filter).sort(ascending("nome"))
                .forEach(doc -> System.out.println(doc.toJson().indent(4)));
        long endTime = System.nanoTime();
        long duration = (endTime - startTime);
        System.out.println("Tempo de execução sem indices: " + duration / 1000000 + "ms\n\n");

        restaurantesCollection.createIndex(Indexes.ascending("localidade"));
        restaurantesCollection.createIndex(Indexes.ascending("gastronomia"));
        restaurantesCollection.createIndex(Indexes.text("nome"));

        startTime = System.nanoTime();
        filter = Filters.and(Filters.eq("localidade", "Bronx"), Filters.eq("gastronomia", "Mexican"), Filters.eq("nome", "Vista Hermosa Deli Restaurant"));
        restaurantesCollection.find(filter).sort(ascending("nome"))
                .forEach(doc -> System.out.println(doc.toJson().indent(4)));
        endTime = System.nanoTime();
        duration = (endTime - startTime);
        System.out.println("Tempo de execução com indices: " + duration / 1000000 + "ms\n\n");

        mongoClient.close();
    }
}