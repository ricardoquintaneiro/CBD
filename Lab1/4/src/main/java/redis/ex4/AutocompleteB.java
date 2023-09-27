package redis.ex4;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;
import redis.clients.jedis.resps.ScanResult;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

public class AutocompleteB {

    private static final String KEY_NOMES = "nomes_popularity";
    private static final String KEY_POPULARITY = "popularity";
    private Jedis jedis;

    public AutocompleteB() {
        this.jedis = new Jedis();
    }

    public void saveName(String username, int popularity) {
        jedis.sadd(KEY_NOMES, username);
        jedis.hset(KEY_POPULARITY, username, String.valueOf(popularity));
    }

    public Set<String> getNomes() {
        return jedis.smembers(KEY_NOMES);
    }

    public List<String> getMatches(String prefix) {
        ScanParams params = new ScanParams();
        params.match(prefix + "*");
        String cursor = ScanParams.SCAN_POINTER_START;
        List<String> results = new ArrayList<>();
        do {
            ScanResult<String> scanResult = jedis.sscan(KEY_NOMES, cursor, params);
            List<String> partialResults = scanResult.getResult();
            results.addAll(partialResults);
            cursor = scanResult.getCursor();
        } while (!cursor.equals(ScanParams.SCAN_POINTER_START));
        results.sort((name1, name2) -> {
            String popularity1 = jedis.hget(KEY_POPULARITY, name1);
            String popularity2 = jedis.hget(KEY_POPULARITY, name2);
            if (popularity1 != null && popularity2 != null) {
                int p1 = Integer.parseInt(popularity1);
                int p2 = Integer.parseInt(popularity2);
                return Integer.compare(p2, p1);
            } else if (popularity1 != null) {
                return -1;
            } else if (popularity2 != null) {
                return 1;
            } else {
                return 0;
            }
        });
        return results;
    }

    public void loadNamesAndPopularityFromFile(String filePath) {
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(";");
                if (parts.length >= 2) {
                    String name = parts[0].trim();
                    int popularity = Integer.parseInt(parts[1].trim());
                    saveName(name, popularity);
                }
            }
        } catch (IOException e) {
            System.out.println("File not found: " + filePath);
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        AutocompleteB board = new AutocompleteB();
        board.loadNamesAndPopularityFromFile("./src/main/resources/nomes-pt-2021.csv");

        Scanner sc = new Scanner(System.in);
        while (true) {
            System.out.print("Search for ('Enter' to quit): ");
            String prefix = sc.nextLine();
            if (prefix.isEmpty())
                break;
            List<String> matches = board.getMatches(prefix);
            matches.forEach(System.out::println);
            System.out.println();
        }
        sc.close();
    }
}
