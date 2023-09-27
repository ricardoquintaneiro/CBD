package redis.ex3;

import java.util.List;
import java.util.Map;
import java.util.Set;
import redis.clients.jedis.Jedis;
 
public class SimplePost {
 
	private Jedis jedis;
	public static String USERS = "users"; // Key set for users' name
	public static String USERSLIST = "userslist"; // Key set for users' name
	public static String USERSHASHMAP = "usershashmap"; // Key set for users' name
	
	public SimplePost() {
		this.jedis = new Jedis();
	}
 
	public void saveUser(String username) {
		jedis.sadd(USERS, username);
	}

	public void saveUserList(String username) {
		jedis.lpush(USERSLIST, username);
	}

	public void saveUserHashMap(String username, String value) {
		jedis.hset(USERSHASHMAP, username, value);
	}

	public Set<String> getUser() {
		return jedis.smembers(USERS);
	}

	public List<String> getUserList() {
		return jedis.lrange(USERSLIST, 0, -1);
	}

	public Map<String, String> getUserHashMap() {
		return jedis.hgetAll(USERSHASHMAP);
	}
	
	public Set<String> getAllKeys() {
		return jedis.keys("*");
	}
 
	public static void main(String[] args) {
		SimplePost board = new SimplePost();
		// set some users
		String[] users = { "Ana", "Pedro", "Maria", "Luis" };
		String[] usersList = {"Joao", "Luis", "Jose", "Gameiro"};
		String[] usersHashMap = {"Fabio", "123", "Ricardo", "456", "Manuel", "789"};
		for (String user: users) 
			board.saveUser(user);
		for (String user: usersList) 
			board.saveUserList(user);
		for (int i = 0; i < usersHashMap.length; i+=2) 
			board.saveUserHashMap(usersHashMap[i], usersHashMap[i+1]);
		System.out.println("All keys:");
		board.getAllKeys().stream().forEach(System.out::println);
		System.out.println("\nUser set:");
		board.getUser().stream().forEach(System.out::println);
		System.out.println("\nUser list:");
		board.getUserList().stream().forEach(System.out::println);
		System.out.println("\nUser hash map:");
		board.getUserHashMap().entrySet().stream().forEach(System.out::println);
		
	}
}



