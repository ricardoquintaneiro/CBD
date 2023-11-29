// 7. Permitir a pesquisa de todos os videos de determinado autor;
SELECT * FROM videos WHERE autor=0aee4739-3d74-430b-be8f-542a91990d9f;

// 8. Permitir a pesquisa de comentarios por utilizador, ordenado inversamente pela data;
SELECT * FROM comentarios_por_utilizador WHERE autor=0aee4739-3d74-430b-be8f-542a91990d9f ORDER BY timestamp DESC;

// 9. Permitir a pesquisa de comentarios por videos, ordenado inversamente pela data;
SELECT * FROM comentarios_por_video WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c ORDER BY timestamp DESC;

// 10. Permitir a pesquisa do rating medio de um video e quantas vezes foi votado;
SELECT AVG(CAST(rating as DOUBLE)) as media_rating, COUNT(rating) as votos FROM ratings_video WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c;


// 1. Os ultimos 3 comentarios introduzidos para um video;
SELECT * FROM comentarios_por_video WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c ORDER BY timestamp DESC LIMIT 3;
 
// 2. Lista das tags de determinado video;
SELECT tags FROM videos WHERE autor=70dd0f2f-1c2d-452a-9fbf-91096b421c74 AND timestamp='2023-11-29 17:09:38.989000+0000' AND id=40e4b650-c3a1-4716-904d-2e4187ba9c6f;

// 3. Todos os videos com a tag Aveiro;
Esta query não é possível de se realizar devido à estrutura da tabela dos vídeos, visto esta pesquisa não ser um requisito.
No entanto, podia-se criar um índice para a coluna tags. Assumindo que se podia criar o índice, a criação do índice e a query seriam:
    CREATE INDEX ON videos(tags);
    SELECT * FROM videos WHERE tags CONTAINS 'Aveiro';

// 4. Os ultimos 5 eventos de determinado video realizados por um utilizador;
SELECT * FROM eventos WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c ORDER BY timestamp DESC LIMIT 5;

// 5. Videos partilhados por determinado utilizador (maria1987, por exemplo) num determinado periodo de tempo (Agosto de 2017, por exemplo);
SELECT * FROM videos WHERE autor=0aee4739-3d74-430b-be8f-542a91990d9f AND timestamp >= '2023-08-01' AND timestamp < '2023-09-01';

// 6. Os ultimos 10 videos, ordenado inversamente pela data da partilhada;
Esta query não é possível devido à partition key (autor) não estar restrita, uma vez que estamos a pesquisar por todos os vídeos.

// 7. Todos os seguidores (followers) de determinado video;
SELECT seguidores FROM seguidores_video WHERE video=e88b714b-5cd8-40dd-b629-fb9b1503c578;

// 8. Todos os comentarios (dos videos) que determinado utilizador esta a seguir (following);
Esta query não é possível devido a serem necessários JOINs entre tabelas, o que não é possível em Cassandra.

// 9. Os 5 videos com maior rating;
Esta query não é possível porque não é possível ordenar por uma coluna que não seja a partition key, logo não é possível ordenar pela média de rating.

// 10. Uma query que retorne todos os videos e que mostre claramente a forma pela qual estao ordenados;
Esta query não é possível porque não podemos ordenar sem restringir a partition key. Além disso, quando pesquisamos por todos os vídeos usando query default (SELECT * FROM videos;)
    os resultados estão ordenados pelas partition keys, mas isso é apenas garantido para uma partição de cada vez, logo o resultado todo pode não estar ordenado.
    

// 11. Lista com as Tags existentes e o numero de videos catalogados com cada uma delas;
Esta query não é possível devido à necessidade de separar os sets de tags em tags individuais, e juntar com os vídeos que as contêm.

// 12. Retornar o nome, descricao e as tags de um determinado video;
SELECT nome, descricao, tags FROM videos WHERE autor=70dd0f2f-1c2d-452a-9fbf-91096b421c74 AND timestamp='2023-11-29 17:09:38.989000+0000' AND id=40e4b650-c3a1-4716-904d-2e4187ba9c6f;

// 13. Retornar o primeiro comentário de um determinado video;
SELECT * FROM comentarios_por_video WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c ORDER BY timestamp ASC LIMIT 1;
