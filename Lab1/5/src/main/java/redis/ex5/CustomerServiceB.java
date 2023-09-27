package redis.ex5;

import java.util.Map;
import java.util.Scanner;

import redis.clients.jedis.Jedis;

public class CustomerServiceB {
    private static final String REDIS_KEY = "customer_service_b:";
    private static final int MAX_UNITS_PER_PRODUCT = 30;
    private static final int TIME_SLOT_IN_SECONDS = 3600;

    private Jedis jedis;

    public CustomerServiceB() {
        this.jedis = new Jedis();
    }

    public boolean requestProduct(String username, String product, int units) {
        String userKey = REDIS_KEY + username;
        String productsKey = userKey + ":product_counts";
        Map<String, String> userData = jedis.hgetAll(userKey);
        long currentTime = System.currentTimeMillis() / 1000;
        long firstRequestTime;
        int requestCount;

        if (!userData.isEmpty() && jedis.hexists(productsKey, product)) {
            requestCount = Integer.parseInt(jedis.hget(productsKey, product));
            firstRequestTime = Long.parseLong(userData.get("first_request_time"));
        } else {
            requestCount = 0;
            firstRequestTime = currentTime;
        }
        if (currentTime - firstRequestTime >= TIME_SLOT_IN_SECONDS) {
            requestCount = 0;
        }
        if (requestCount + units > MAX_UNITS_PER_PRODUCT) {
            return false;
        }
        jedis.hset(userKey, "first_request_time", String.valueOf(currentTime));
        jedis.hset(productsKey, product, String.valueOf(requestCount + units));
        return true;
    }

    public void clearAllRequests(String username) {
        String userKey = REDIS_KEY + username;
        String productsKey = userKey + ":product_counts";
        jedis.del(userKey);
        jedis.del(productsKey);
    }

    public static void main(String[] args) {
        CustomerServiceB customerService = new CustomerServiceB();
        Scanner scanner = new Scanner(System.in);
        System.out.print("Enter your username: ");
        String username = scanner.nextLine();
        while (true) {
            System.out.println("\nOptions:");
            System.out.println("1. Make a request");
            System.out.println("2. Clear all requests");
            System.out.println("3. Exit");
            System.out.print("Enter your choice (1/2/3): ");
            int choice = scanner.nextInt();
            scanner.nextLine();
            switch (choice) {
                case 1:
                    System.out.print("Enter the product name: ");
                    String product = scanner.nextLine();
                    System.out.print("Enter the number of units: ");
                    int units = scanner.nextInt();
                    scanner.nextLine();
                    boolean allowed = customerService.requestProduct(username, product, units);
                    if (allowed) {
                        System.out.println("\nRequest accepted.");
                    } else {
                        System.out.println("\nRequest rejected: Exceeded limit!");
                    }
                    break;
                case 2:
                    customerService.clearAllRequests(username);
                    System.out.println("\nAll requests cleared.");
                    break;
                case 3:
                    System.out.println("\nExiting Customer Service.");
                    scanner.close();
                    System.exit(0);
                default:
                    System.out.println("Invalid choice. Please select 1, 2, or 3.");
            }
        }
    }
}
