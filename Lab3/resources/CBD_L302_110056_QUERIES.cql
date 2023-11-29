// 7. Permitir a pesquisa de todos os videos de determinado autor;
SELECT * from videos where autor=0aee4739-3d74-430b-be8f-542a91990d9f;

// 8. Permitir a pesquisa de comentarios por utilizador, ordenado inversamente pela data;
SELECT * from comentarios_por_utilizador where autor=0aee4739-3d74-430b-be8f-542a91990d9f order by timestamp desc;

// 9. Permitir a pesquisa de comentarios por videos, ordenado inversamente pela data;
SELECT * from comentarios_por_video where video=58e90b21-495a-4c93-811b-91c3a227eb7c order by timestamp desc;

// 10. Permitir a pesquisa do rating medio de um video e quantas vezes foi votado;
SELECT avg(cast(rating as double)) as media_rating, count(rating) as votos from ratings_video where video=58e90b21-495a-4c93-811b-91c3a227eb7c;


// 1. Os ultimos 3 comentarios introduzidos para um video;
SELECT * FROM comentarios_por_video WHERE video=58e90b21-495a-4c93-811b-91c3a227eb7c ORDER BY timestamp DESC LIMIT 3;
 
// 2. Lista das tags de determinado video;
select tags from videos where id=40e4b650-c3a1-4716-904d-2e4187ba9c6f;

// 3. Todos os videos com a tag Aveiro;
Esta query não é possível de se realizar devido à estrutura da tabela dos vídeos, visto esta pesquisa não ser um requisito.
No entanto, podia-se criar um índice para a coluna tags. Assumindo que se podia criar o índice, a criação do índice e a query seriam:
    CREATE INDEX ON videos(tags);
    SELECT * FROM videos WHERE tags CONTAINS 'Aveiro';

// 4. Os ultimos 5 eventos de determinado video realizados por um utilizador;
select * from eventos where video=58e90b21-495a-4c93-811b-91c3a227eb7c order by timestamp desc limit 5;

// 5. Videos partilhados por determinado utilizador (maria1987, por exemplo) num determinado periodo de tempo (Agosto de 2017, por exemplo);
select * from videos where autor=0aee4739-3d74-430b-be8f-542a91990d9f and timestamp >= '2023-08-01' and timestamp < '2023-09-01';

// 6. Os ultimos 10 videos, ordenado inversamente pela data da partilhada;
Esta query não é possível devido à partition key (autor) não estar restrita, uma vez que estamos a pesquisar por todos os vídeos.

// 7. Todos os seguidores (followers) de determinado video;
select seguidores from seguidores_video where video=e88b714b-5cd8-40dd-b629-fb9b1503c578;

// 8. Todos os comentarios (dos videos) que determinado utilizador esta a seguir (following);
Esta query não é possível devido a serem necessários JOINs entre tabelas, o que não é possível em Cassandra.

// 9. Os 5 videos com maior rating;
Esta query não é possível porque não é possível ordenar por uma coluna que não seja a partition key, logo não é possível ordenar pela média de rating.

// 10. Uma query que retorne todos os videos e que mostre claramente a forma pela qual estao ordenados;
Esta query não é possível porque não podemos ordenar sem restringir a partition key. Além disso, quando pesquisamos por todos os vídeos usando query default (SELECT * FROM videos;)
    os resultados estão ordenados pelas partition keys, mas isso é apenas garantido para uma partição de cada vez, logo o resultado todo pode não estar ordenado.
    

// 11. Lista com as Tags existentes e o numero de videos catalogados com cada uma delas;
Esta query não é possível devido à necessidade de JOINs.

// 12.

// 13.
