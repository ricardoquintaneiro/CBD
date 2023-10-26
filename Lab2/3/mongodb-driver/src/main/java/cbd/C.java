package cbd;

import static com.mongodb.client.model.Sorts.ascending;

import java.util.Arrays;
import java.util.List;

import org.bson.Document;
import org.bson.conversions.Bson;

import com.mongodb.ConnectionString;
import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Accumulators;
import com.mongodb.client.model.Aggregates;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Projections;

public class C {
        public static void main(String[] args) {
                ConnectionString connectionString = new ConnectionString(
                                "mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.10.6");
                MongoClient mongoClient = MongoClients.create(connectionString);
                MongoDatabase cbdDatabase = mongoClient.getDatabase("cbd");
                MongoCollection<Document> restaurantesCollection = cbdDatabase.getCollection("restaurants");
                // Ex 10 - 10. Liste o restaurant_id, o nome, a localidade e gastronomia dos
                // restaurantes cujo nome
                // começam por "Wil".
                Bson filter = Filters.regex("nome", "^Wil");
                restaurantesCollection.find(filter)
                                .projection(Projections.include("localidade", "gastronomia", "nome", "restaurant_id"))
                                .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // Ex 12 - Liste o restaurant_id, o nome, a localidade e a gastronomia dos
                // restaurantes
                // localizados em "Staten Island", "Queens", ou "Brooklyn.
                // filter = Filters.or(Filters.in("localidade", Arrays.asList("Staten Island",
                // "Queens", "Brooklyn")));
                // restaurantesCollection.find(filter).projection(Projections.include("localidade",
                // "gastronomia", "nome", "restaurant_id"))
                // .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // // 15. Liste o restaurant_id, o nome e os score dos restaurantes nos quais a
                // segunda
                // // avaliação foi grade "A" e ocorreu em ISODATE "2014-08-11T00: 00: 00Z".
                // // db.restaurants.find({$and:[{"grades.1.grade": "A"} , {"grades.1.date":
                // ISODate("2014-08-11T00:00:00Z")}]},{"_id":0 ,"restaurant_id":1 ,"nome":1,
                // "grades.score":1})
                // filter = Filters.and(Filters.eq("grades.1.grade", "A"),
                // Filters.eq("grades.1.date", "2014-08-11T00:00:00Z"));
                // restaurantesCollection.find(filter).projection(Projections.include("grades",
                // "nome", "restaurant_id"))
                // .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // Ex 19 - Indique o número total de avaliações (numGrades) na coleção.
                // List<Bson> filters =
                // Arrays.asList(Aggregates.group(Accumulators.sum("numGrades", )))));
                // restaurantesCollection.aggregate(filters)
                // .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // Ex 20 - 20. Apresente o nome e número de avaliações (numGrades) dos 3 restaurante com
                // mais avaliações.
                Projection gradesProj = Projections.include("grades");
                String grades = restaurantesCollection.find().projection(gradesProj).;
                List<Bson> filters = Arrays.asList(Aggregates.sort(ascending("numGrades")),
                                Aggregates.limit(3),
                                Aggregates.group("$nome", Accumulators.sum("numGrades", )));
                restaurantesCollection.aggregate(filters).forEach(doc -> System.out.println(doc.toJson().indent(4)));


                mongoClient.close();
        }
}