package redis.ex5;

import java.util.Map;

import redis.clients.jedis.Jedis;

public class CustomerServiceA {
    private static final String REDIS_KEY = "customer_service_a:";
    private static final int MAX_PRODUCTS_PER_USER = 30;
    private static final int TIME_SLOT_IN_SECONDS = 3600;

    private Jedis jedis;

    public CustomerServiceA() {
        this.jedis = new Jedis();
    }

    public boolean requestProduct(String username, String product) {
        String userKey = REDIS_KEY + username;
        Map<String, String> userData = jedis.hgetAll(userKey);
        long currentTime = System.currentTimeMillis() / 1000;
        int requestCount;
        long firstRequestTime;
        if (!userData.isEmpty()) {
            requestCount = Integer.parseInt(userData.get("request_count"));
            firstRequestTime = Long.parseLong(userData.get("first_request_time"));
        } else {
            requestCount = 0;
            firstRequestTime = currentTime;
        }
        if (currentTime - firstRequestTime >= TIME_SLOT_IN_SECONDS) {
            requestCount = 0;
        }
        if (requestCount >= MAX_PRODUCTS_PER_USER) {
            return false;
        }
        jedis.hset(userKey, "request_count", String.valueOf(requestCount + 1));
        jedis.hset(userKey, "first_request_time", String.valueOf(currentTime));
        jedis.rpush(userKey + ":requests", product);
        return true;
    }

    public static void main(String[] args) {
        CustomerServiceA customerService = new CustomerServiceA();
        String username = "ricardo";
        String product = "product";
        for (int i = 0; i < 32; i++) {
            boolean allowed = customerService.requestProduct(username, product + String.valueOf(i));
            System.out.print("Product number: " + String.valueOf(i + 1) + ". ");
            if (allowed) {
                System.out.println("Request accepted.");
            } else {
                System.out.println("Request rejected: Exceeded limit.");
            }
        }
    }
}
