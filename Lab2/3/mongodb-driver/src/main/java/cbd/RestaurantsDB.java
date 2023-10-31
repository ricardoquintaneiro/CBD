package cbd;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.bson.Document;

import com.mongodb.ConnectionString;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;

public class RestaurantsDB {

    private ConnectionString connectionString;
    private MongoClient mongoClient;
    private MongoDatabase cbdDatabase;
    private MongoCollection<Document> restaurantsCollection;

    public RestaurantsDB() {
        this.connectionString = new ConnectionString(
                "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.10.6");
        this.mongoClient = MongoClients.create(connectionString);
        this.cbdDatabase = mongoClient.getDatabase("cbd");
        this.restaurantsCollection = cbdDatabase.getCollection("restaurants");
    }

    public void close() {
        mongoClient.close();
    }

    public int countLocalidades() {
        List<Object> localidades = this.restaurantsCollection
                .distinct("localidade", String.class)
                .into(new ArrayList<>());
        // System.out.println(localidades.toString());
        return localidades.size();
    }

    public Map<String, Integer> countRestByLocalidade() {
        Map<String, Integer> countRestByLocalidade = new HashMap<>();
        List<Object> localidades = this.restaurantsCollection
                .distinct("localidade", String.class)
                .into(new ArrayList<>());
        for (Object localidade : localidades) {
            countRestByLocalidade.put((String) localidade,
                    (int) this.restaurantsCollection.countDocuments(Filters.eq("localidade", localidade)));
        }
        return countRestByLocalidade;
    }

    public List<String> getRestWithNameCloserTo(String name) {
        List<String> restWithNameCloserTo = new ArrayList<>();
        this.restaurantsCollection
                .find(Filters.regex("nome", name))
                .projection(new Document("nome", 1))
                .into(new ArrayList<>())
                .forEach(doc -> restWithNameCloserTo.add(doc.getString("nome")));
        return restWithNameCloserTo;
    }
     
    public MongoCollection<Document> getRestaurantsCollection() {
        return restaurantsCollection;
    }

}
