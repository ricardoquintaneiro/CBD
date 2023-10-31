package cbd;

import static com.mongodb.client.model.Sorts.ascending;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Indexes;

public class B {
    public static void main(String[] args) {
        RestaurantsDB restaurantsDB = new RestaurantsDB();

        MongoCollection<Document> restaurantsCollection = restaurantsDB.getRestaurantsCollection();

        restaurantsCollection.dropIndexes();

        long startTime = System.nanoTime();
        Bson filter = Filters.and(Filters.eq("localidade", "Bronx"), Filters.eq("gastronomia", "Mexican"), Filters.eq("nome", "Vista Hermosa Deli Restaurant"));
        restaurantsCollection.find(filter).sort(ascending("nome"))
                .forEach(doc -> System.out.println(doc.toJson().indent(4)));
        long endTime = System.nanoTime();
        long duration = (endTime - startTime);
        System.out.println("Tempo de execução sem indices: " + duration / 1000000 + "ms\n\n");

        restaurantsCollection.createIndex(Indexes.ascending("localidade"));
        restaurantsCollection.createIndex(Indexes.ascending("gastronomia"));
        restaurantsCollection.createIndex(Indexes.text("nome"));

        startTime = System.nanoTime();
        filter = Filters.and(Filters.eq("localidade", "Bronx"), Filters.eq("gastronomia", "Mexican"), Filters.eq("nome", "Vista Hermosa Deli Restaurant"));
        restaurantsCollection.find(filter).sort(ascending("nome"))
                .forEach(doc -> System.out.println(doc.toJson().indent(4)));
        endTime = System.nanoTime();
        duration = (endTime - startTime);
        System.out.println("Tempo de execução com indices: " + duration / 1000000 + "ms\n\n");
    }
}