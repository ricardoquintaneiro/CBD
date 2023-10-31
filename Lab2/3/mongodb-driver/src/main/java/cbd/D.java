package cbd;

public class D {
    public static void main(String[] args) {
        RestaurantsDB restaurantsDB = new RestaurantsDB();
         
        System.out.println("Número de localidades: " + restaurantsDB.countLocalidades());
         
        System.out.println("\nNúmero de restaurantes por localidade:");
        restaurantsDB.countRestByLocalidade().forEach((k, v) -> System.out.println(" -> " + k + " = " + v));

        System.out.println("\nNome de restaurantes contendo 'Park' no nome:");    
        restaurantsDB.getRestWithNameCloserTo("Park").forEach(k  -> System.out.println(" -> " + k));

        restaurantsDB.close();
    }
}
