package redis.ex4;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.List;
import java.util.Scanner;
import java.util.Set;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.params.ScanParams;

public class Names {

    private Jedis jedis;
	public static String NOMES = "nomes"; // Key set for users' name
	
	public Names() {
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
		List<String> results = jedis.sscan(NOMES, ScanParams.SCAN_POINTER_START, params).getResult();
		results.stream().forEach(System.out::println);
		return results;
	}
	
    public static void main(String[] args) {
		File ficheiro_nomes = new File("./ex4/names.txt");
		try (Scanner sc = new Scanner(ficheiro_nomes)) {
			Names board = new Names();
			while (sc.hasNextLine()) {
				board.saveName(sc.nextLine());
			}
			sc.close();
		} catch (FileNotFoundException e) {
			System.out.println("Ficheiro não encontrado.");
			e.printStackTrace();
		}

		Names board = new Names();
		board.getNomes().stream().forEach(System.out::println);
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