package pt.ua.cbd.lab3.ex3;

import java.util.Set;
import java.util.UUID;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.ResultSet;

public class ExB {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {
            // 10. Permitir a pesquisa do rating medio de um video e quantas vezes foi votado;
            // SELECT avg(cast(rating as double)) as media_rating, count(rating) as votos from ratings_video where video=58e90b21-495a-4c93-811b-91c3a227eb7c;
            System.out.println();
            UUID video = UUID.fromString("58e90b21-495a-4c93-811b-91c3a227eb7c");
            ResultSet rs = session.execute("SELECT avg(cast(rating as double)) as media_rating, count(rating) as votos from cbd.ratings_video where video=?", video);
            System.out.println("Media rating: " + rs.one().getDouble("media_rating"));

            // 1. Os ultimos 3 comentarios introduzidos para um video;>
            // SELECT * FROM comentarios_por_video WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c ORDER BY timestamp DESC LIMIT 3;>
            System.out.println();
            video = UUID.fromString("58e90b21-495a-4c93-811b-91c3a227eb7c");
            rs = session.execute("SELECT * FROM cbd.comentarios_por_video WHERE video=? ORDER BY timestamp DESC LIMIT 3", video);
            System.out.println("Ultimos 3 comentarios deste video:");
            rs.all().stream().forEach(row -> System.out.println("\t" + row.getString("texto")));


            // 5. Videos partilhados por determinado utilizador (maria1987, por exemplo) num determinado periodo de tempo (Agosto de 2017, por exemplo);
            //select * from videos where autor=0aee4739-3d74-430b-be8f-542a91990d9f and timestamp >= '2023-08-01' and timestamp < '2023-09-01';
            System.out.println();
            UUID autor = UUID.fromString("0aee4739-3d74-430b-be8f-542a91990d9f");
            rs = session.execute("select * from cbd.videos where autor=? and timestamp >= '2023-08-01' and timestamp < '2023-09-01'", autor);
            System.out.println("Videos de Agosto de 2023 deste utilizador:");
            rs.all().stream().forEach(row -> System.out.println("\t" + row.getString("nome")));


            // 7. Todos os seguidores (followers) de determinado video;
            // select seguidores from seguidores_video where video=e88b714b-5cd8-40dd-b629-fb9b1503c578;
            System.out.println();
            video = UUID.fromString("e88b714b-5cd8-40dd-b629-fb9b1503c578");
            rs = session.execute("select seguidores from cbd.seguidores_video where video=?", video);
            System.out.println("Seguidores deste video:");
            rs.forEach(row -> {
                Set<UUID> followers = row.getSet("seguidores", UUID.class);
                followers.forEach(follower -> System.out.println("\t" + follower));
            });
        }
    }
}
