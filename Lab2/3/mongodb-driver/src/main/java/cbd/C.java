package cbd;

import static com.mongodb.client.model.Sorts.ascending;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
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
                System.out.println("Ex 10\n");

                Bson filter = Filters.regex("nome", "^Wil");
                restaurantesCollection.find(filter)
                                .projection(Projections.fields(Projections.include("restaurant_id", "nome",
                                                "localidade", "gastronomia"), Projections.excludeId()))
                                .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // Ex 12 - Liste o restaurant_id, o nome, a localidade e a gastronomia dos
                // restaurantes localizados em "Staten Island", "Queens", ou "Brooklyn.

                // LIMITADO A 3 RESULTADOS

                System.out.println("Ex 12 - Limitado a 3 resultados\n");

                filter = Filters.or(Filters.in("localidade", Arrays.asList("Staten Island",
                                "Queens", "Brooklyn")));
                restaurantesCollection.find(filter).projection(Projections.fields(Projections.include("localidade",
                                "gastronomia", "nome", "restaurant_id"), Projections.excludeId()))
                                .limit(3)
                                .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // // 15. Liste o restaurant_id, o nome e os score dos restaurantes nos quais a
                // segunda
                // // avaliação foi grade "A" e ocorreu em ISODATE "2014-08-11T00: 00: 00Z".
                System.out.println("Ex 15\n");

                DateTimeFormatter dateFormat = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss'Z'");

                filter = Filters.and(Filters.eq("grades.1.grade", "A"),
                                Filters.eq("grades.1.date",
                                                LocalDateTime.from(dateFormat.parse("2014-08-11T00:00:00Z"))));
                restaurantesCollection.find(filter).projection(Projections.fields(Projections.include("grades.score",
                                "nome", "restaurant_id"), Projections.excludeId()))
                                .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // Ex 19 - Indique o número total de avaliações (numGrades) na coleção.
                System.out.println("Ex 19\n");

                List<Bson> filters = Arrays.asList(
                                Aggregates.group("restaurants",
                                                Accumulators.sum("numGrades", new Document("$sum",
                                                                new Document("$size", "$grades")))));
                restaurantesCollection.aggregate(filters)
                                .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                // Ex 20 - 20. Apresente o nome e número de avaliações (numGrades) dos 3
                // restaurante com
                // mais avaliações.
                System.out.println("Ex 20\n");

                List<Bson> aggregationFilters = Arrays.asList(
                                Aggregates.group("$nome",
                                                Accumulators.sum("numGrades",
                                                                new Document("$sum",
                                                                                new Document("$size", "$grades")))),
                                Aggregates.sort(new Document("numGrades", -1)),
                                Aggregates.limit(3));
                restaurantesCollection.aggregate(aggregationFilters)
                                .forEach(doc -> System.out.println(doc.toJson().indent(4)));

                mongoClient.close();
        }
}