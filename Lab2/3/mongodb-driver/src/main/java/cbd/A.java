package cbd;

import static com.mongodb.client.model.Sorts.ascending;

import java.util.Arrays;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;

public class A {
    public static void main(String[] args) {
        RestaurantsDB restaurantsDB = new RestaurantsDB();

        MongoCollection<Document> restaurantsCollection = restaurantsDB.getRestaurantsCollection();

        Bson filter = Filters.and(Filters.eq("localidade", "Bronx"), Filters.gt("grades.score", 65));
        restaurantsCollection.find(filter).sort(ascending("nome")).forEach(doc -> System.out.println(doc.toJson().indent(4)));

        Document newRestaurant = new Document("address", new Document("building", "1").append("coord", Arrays.asList(40.0, 50.0)).append("rua", "Rua da Igreja").append("zipcode", "3840-000"))
            .append("localidade", "Vagos")
            .append("gastronomia", "Portuguese")
            .append("grades", Arrays.asList(new Document("date", "2023-10-19T00:00:00Z").append("grade", "A").append("score", 100)))
            .append("nome", "Café do Ric")
            .append("restaurant_id", "999999999");

        restaurantsCollection.insertOne(newRestaurant);
        
        filter = Filters.eq("nome", "Café do Ric");
        restaurantsCollection.find(filter).forEach(doc -> System.out.println(doc.toJson().indent(4)));

        restaurantsCollection.deleteMany(filter);
    }
}