package redis.ex5;

import java.util.Map;

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

    public static void main(String[] args) {
        CustomerServiceB customerService = new CustomerServiceB();

        String username = "ricardo";
        String product = "product";
        int units = 30;

        for (int i = 0; i < 2; i++) {
            boolean allowed = customerService.requestProduct(username, product + String.valueOf(i), units + i);
            System.out.print("Product: " + String.valueOf(i + 1) + ". Units: " + String.valueOf(units + i));
            if (allowed) {
                System.out.println("\tRequest accepted.");
            } else {
                System.out.println("\tRequest rejected: Exceeded limit.");
            }
        }

        boolean allowed = customerService.requestProduct(username, "product3", 29);
        System.out.print("Product: " + 3 + ". Units: " + String.valueOf(29));
        if (allowed) {
            System.out.println("\tRequest accepted.");
        } else {
            System.out.println("\tRequest rejected: Exceeded limit.");
        }

        allowed = customerService.requestProduct(username, "product3", 2);
        System.out.print("Product: " + 3 + ". Units: " + String.valueOf(2));
        if (allowed) {
            System.out.println("\tRequest accepted.");
        } else {
            System.out.println("\tRequest rejected: Exceeded limit.");
        }

        allowed = customerService.requestProduct(username, "product3", 1);
        System.out.print("Product: " + 3 + ". Units: " + String.valueOf(1));
        if (allowed) {
            System.out.println("\tRequest accepted.");
        } else {
            System.out.println("\tRequest rejected: Exceeded limit.");
        }
    }
}
