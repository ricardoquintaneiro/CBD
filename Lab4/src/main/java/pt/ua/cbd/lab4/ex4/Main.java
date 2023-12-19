package pt.ua.cbd.lab4.ex4;

import java.io.FileWriter;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.neo4j.driver.AuthTokens;
import org.neo4j.driver.Driver;
import org.neo4j.driver.GraphDatabase;
import org.neo4j.driver.Result;

public class Main implements AutoCloseable {
    private final Driver driver;

    public Main(String uri, String user, String password) {
        driver = GraphDatabase.driver(uri, AuthTokens.basic(user, password));
    }

    @Override
    public void close() throws Exception {
        driver.close();
    }

    public void createDatabase() {
        try (var session = driver.session()) {
            session.run("MATCH (n) DETACH DELETE n;");

            session.run("LOAD CSV WITH HEADERS FROM 'file:///resources/circuits.csv' AS row " +
                    "MERGE (l:Location {name: row.location}) " +
                    "MERGE (c:Country {name: row.country}) " +
                    "MERGE (l)-[:BELONGS_TO]->(c)" +
                    "MERGE (circuit:Circuit { " +
                    "circuitId: toInteger(row.circuitId), " +
                    "circuitRef: row.circuitRef, " +
                    "name: row.name, " +
                    "lat: toFloat(row.lat), " +
                    "lng: toFloat(row.lng), " +
                    "url: row.url " +
                    "}) " +
                    "MERGE (circuit)-[:LOCATED_IN]->(l);");

            session.run("LOAD CSV WITH HEADERS FROM 'file:///resources/races.csv' AS row " +
                    "MATCH (circuit:Circuit {circuitId: toInteger(row.circuitId)}) " +
                    "CREATE (race:Race { " +
                    "raceId: toInteger(row.raceId), " +
                    "year: toInteger(row.year), " +
                    "round: toInteger(row.round), " +
                    "name: row.name + ' ' + row.year, " +
                    "date: date(row.date), " +
                    "url: row.url " +
                    "}) " +
                    "MERGE (race)-[:HELD_AT]->(circuit);");
        }
    }

    public List<String> circuitsByCountry(String country) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (circuit:Circuit)-[:LOCATED_IN]->(:Location)-[:BELONGS_TO]->(country:Country {name: $country}) "
                            +
                            "RETURN circuit.name AS name",
                    Map.of("country", country));

            return result.list(record -> record.get("name").asString());
        }
    }

    public List<String> racesByCircuit(String circuit) {
        try (var session = driver.session()) {
            Result result = session.run("MATCH (r:Race)-[:HELD_AT]->(circuit:Circuit {name: $circuit_name}) " +
                    "RETURN r.name, r.year ORDER BY r.year", Map.of("circuit_name", circuit));

            return result.list(record -> record.get("r.name").asString());
        }
    }

    public List<String> circuitsByYear(int year) {
        try (var session = driver.session()) {
            Result result = session.run("MATCH (race:Race {year: $year})-[:HELD_AT]->(circuit:Circuit)" +
                    "RETURN DISTINCT circuit.name;", Map.of("year", year));

            return result.list(record -> record.get("circuit.name").asString());
        }
    }

    public List<String> racesInBetweenDates(String startDate, String endDate) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (race:Race)-[:HELD_AT]->(circuit:Circuit) " +
                            "WHERE date(race.date) >= date($startDate) AND date(race.date) <= date($endDate) "
                            +
                            "RETURN DISTINCT race.name;",
                    Map.of("startDate", startDate, "endDate", endDate));

            return result.list(record -> record.get("race.name").asString());
        }
    }

    public Map<String, Integer> topCircuitsWithMoreRaces(int limit) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (circuit:Circuit)<-[:HELD_AT]-(race:Race) " +
                            "WITH circuit, COUNT(race) AS raceCount " +
                            "RETURN circuit.name, raceCount " +
                            "ORDER BY raceCount DESC " +
                            "LIMIT $limit;",
                    Map.of("limit", limit));

            return result.stream()
                    .collect(Collectors.toMap(
                            record -> record.get("circuit.name").asString(),
                            record -> record.get("raceCount").asInt()));
        }
    }

    public List<String> getCircuitsForRound(int round) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (circuit:Circuit)<-[:HELD_AT]-(race:Race {round: $round}) " +
                            "RETURN DISTINCT circuit.name;",
                    Map.of("round", round));

            return result.list(record -> record.get("circuit.name").asString());
        }
    }

    public List<Map<String, Object>> getTopCountriesWithMoreRaces(int limit) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (country:Country)<-[:BELONGS_TO]-(:Location)<-[:LOCATED_IN]-(circuit:Circuit)<-[:HELD_AT]-(race:Race) "
                            +
                            "WITH country, COUNT(race) AS raceCount " +
                            "RETURN country.name AS countryName, raceCount " +
                            "ORDER BY raceCount DESC " +
                            "LIMIT $limit;",
                    Map.of("limit", limit));

            return result.list(record -> record.asMap());
        }
    }

    public Map<String, String> getMostRecentRaceForEachCircuit() {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (circuit:Circuit)<-[:HELD_AT]-(race:Race) " +
                            "WITH circuit, race " +
                            "ORDER BY race.date DESC " +
                            "RETURN circuit.name AS circuitName, COLLECT(race.name)[0] AS mostRecentRaceName " +
                            "ORDER BY circuitName;");

            return result.list(record -> {
                Map<String, Object> map = record.asMap();
                return Map.entry((String) map.get("circuitName"), (String) map.get("mostRecentRaceName"));
            }).stream()
                    .collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
        }
    }

    public List<String> racesByCountry(String country) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (race:Race)-[:HELD_AT]->(circuit:Circuit)-[:LOCATED_IN]-(:Location)-[:BELONGS_TO]->(country:Country {name: $country}) "
                            +
                            "RETURN race.name AS raceName;",
                    Map.of("country", country));

            return result.list(record -> record.get("raceName").asString());
        }
    }

    public List<String> circuitsByCity(String city) {
        try (var session = driver.session()) {
            Result result = session.run(
                    "MATCH (circuit:Circuit)-[:LOCATED_IN]->(location:Location {name: $city}) " +
                            "RETURN circuit.name AS circuitName;",
                    Map.of("city", city));

            return result.list(record -> record.get("circuitName").asString());
        }
    }

    public static void main(String... args) {
        try (var circuitDatabase = new Main("bolt://localhost:7687", "neo4j", "password")) {

            circuitDatabase.createDatabase();

            try (FileWriter fw = new FileWriter("CBD-L44c_output.txt")) {

                fw.write("\nNames of circuits in Portugal:\n");
                circuitDatabase.circuitsByCountry("Portugal").forEach(circuit -> {
                    try {
                        fw.write("\t" + circuit + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nNames of races at Nürburgring:\n");
                circuitDatabase.racesByCircuit("Nürburgring").forEach(race -> {
                    try {
                        fw.write("\t" + race + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nNames of the circuits where races where held in 2009:\n");
                circuitDatabase.circuitsByYear(2009).forEach(circuit -> {
                    try {
                        fw.write("\t" + circuit + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nRaces held in between 2018-07-01 and 2018-10-21 included:\n");
                circuitDatabase.racesInBetweenDates("2018-07-01", "2018-10-21").forEach(race -> {
                    try {
                        fw.write("\t" + race + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nReturn the top 5 of circuits where more races were held in and their count:\n");
                circuitDatabase.topCircuitsWithMoreRaces(5).forEach((circuit, count) -> {
                    try {
                        fw.write("\tCircuit: " + circuit + ", race count: " + count + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nReturn the circuits that held round 3 races:\n");
                circuitDatabase.getCircuitsForRound(3).forEach(circuit -> {
                    try {
                        fw.write("\t" + circuit + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nReturn the top 10 of countries with more races and their count:\n");
                circuitDatabase.getTopCountriesWithMoreRaces(10).forEach(pair -> {
                    try {
                        String values = pair.values().toString();
                        fw.write("\t" + values.substring(1, values.length() - 1) + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nFind the most recent race for each circuit:\n");
                circuitDatabase.getMostRecentRaceForEachCircuit().forEach((circuitName, mostRecentRaceName) -> {
                    try {
                        fw.write("\t" + circuitName + ": " + mostRecentRaceName + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nNames of races in Italy:\n");
                circuitDatabase.racesByCountry("Italy").forEach(race -> {
                    try {
                        fw.write("\t" + race + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });

                fw.write("\nNames of circuits in Barcelona:\n");
                circuitDatabase.circuitsByCity("Barcelona").forEach(circuit -> {
                    try {
                        fw.write("\t" + circuit + "\n");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                });
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}