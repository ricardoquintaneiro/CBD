package redis.ex4;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;
import redis.clients.jedis.resps.ScanResult;

public class AutocompleteA {

    private Jedis jedis;
	public static String NOMES = "nomes"; // Key set for users' name
	
	public AutocompleteA() {
		this.jedis = new Jedis();
	}
 
	public void saveName(String username) {
		jedis.sadd(NOMES, username);
	}

	public Set<String> getNomes() {
		return jedis.smembers(NOMES);
	}

	public List<String> getMatches(String prefix) {
		ScanParams params = new ScanParams();
        params.match(prefix + "*");
        String cursor = ScanParams.SCAN_POINTER_START;
        List<String> results = new java.util.ArrayList<>();
        do {
            ScanResult<String> scanResult = jedis.sscan(NOMES, cursor, params);
            List<String> partialResults = scanResult.getResult();
            results.addAll(partialResults);
            cursor = scanResult.getCursor();
        } while (!cursor.equals(ScanParams.SCAN_POINTER_START));
        return results;
	}
	
    public static void main(String[] args) {
		File ficheiro_nomes = new File("./src/main/resources/names.txt");
		try (Scanner sc = new Scanner(ficheiro_nomes)) {
			AutocompleteA board = new AutocompleteA();
						while (sc.hasNextLine()) {
				board.saveName(sc.nextLine());
			}
			sc.close();
		} catch (FileNotFoundException e) {
			System.out.println("File not found.");
			e.printStackTrace();
		}

		AutocompleteA board = new AutocompleteA();
		System.out.print("Search for ('Enter' for quit): ");
		Scanner sc = new Scanner(System.in);
		String prefix = sc.nextLine();
		while (!prefix.equals("")) {
			board.getMatches(prefix).stream().forEach(System.out::println);
			System.out.print("Search for ('Enter' for quit): ");
			prefix = sc.nextLine();
		}
		sc.close();
		
    }
}