package pt.ua.cbd.lab3.ex3;

import java.time.Instant;
import java.util.Arrays;
import java.util.HashSet;
import java.util.UUID;

import com.datastax.oss.driver.api.core.CqlSession;
import com.datastax.oss.driver.api.core.cql.PreparedStatement;
import com.datastax.oss.driver.api.core.cql.ResultSet;
import com.datastax.oss.driver.api.core.cql.Row;

public class ExA {
    public static void main(String[] args) {
        try (CqlSession session = CqlSession.builder().build()) {

            // inserts
            PreparedStatement preparedInsertUtilizador = session.prepare(
                    "INSERT INTO cbd.utilizadores(id, username, nome, email, timestamp) VALUES (?, ?, ?, ?, ?);");
            PreparedStatement preparedInsertVideo = session.prepare(
                    "INSERT INTO cbd.videos(id, autor, nome, descricao, tags, timestamp) VALUES (?, ?, ?, ?, ?, ?);");

            session.execute(preparedInsertUtilizador
                    .bind(UUID.fromString("b9f5bf60-173b-4a00-b97c-117a91f6909b"), "jrds", "José Rodrigues ds Santos",
                            "jdrs@example.com", Instant.now()));
            session.execute(preparedInsertUtilizador
                    .bind(UUID.fromString("853d9a25-107b-4318-ab4e-91f097004eaf"),"jg", "Jorge Gabriel", "jg@example.com",
                            Instant.now()));
                             
            session.execute(preparedInsertVideo
                    .bind(UUID.fromString("3f0bc4f7-bd46-4cca-8ce9-ef33b73a1352"),
                            UUID.fromString("b9f5bf60-173b-4a00-b97c-117a91f6909b"), "Melhores introduções das notícias da RTP",
                            "One-liners do melhor jornalista.", new HashSet<>(Arrays.asList("Notícias", "Highlights")), Instant.now()));

            session.execute(preparedInsertVideo
                    .bind(UUID.fromString("564bb07f-0455-48c1-a313-6287f0be60a5"),
                            UUID.fromString("853d9a25-107b-4318-ab4e-91f097004eaf"), "Praça da Alegra 2023 COMPLETO",
                            "As melhores manhãs...", new HashSet<>(Arrays.asList("Entretenimento")), Instant.now()));

            // update
            session.execute(
                    "UPDATE cbd.utilizadores SET nome='José Rodrigues dos Santos' WHERE id=b9f5bf60-173b-4a00-b97c-117a91f6909b;");

            // select
            ResultSet rs = session.execute("SELECT * FROM cbd.utilizadores");
            for (Row row : rs.all()) {
                System.out.println(row.getString("nome"));
            }

            rs = session.execute("SELECT * FROM cbd.videos");
            for (Row row : rs.all()) {
                System.out.println(row.getString("nome") + " - " + row.getString("descricao"));
            }
        }
    }
}
