// 7. Permitir a pesquisa de todos os videos de determinado autor;
select * from videos where autor=0aee4739-3d74-430b-be8f-542a91990d9f;

// 8. Permitir a pesquisa de comentarios por utilizador, ordenado inversamente pela data;
select * from comentarios_por_utilizador where autor=0aee4739-3d74-430b-be8f-542a91990d9f order by timestamp desc;

// 9. Permitir a pesquisa de comentarios por videos, ordenado inversamente pela data;
select * from comentarios_por_video where video=58e90b21-495a-4c93-811b-91c3a227eb7c order by timestamp desc;

// 10. Permitir a pesquisa do rating medio de um video e quantas vezes foi votado;
select avg(cast(rating as double)) as media_rating, count(rating) as votos from ratings_video where video=58e90b21-495a-4c93-811b-91c3a227eb7c;


// 1. Os ultimos 3 comentarios introduzidos para um video;

// 2. Lista das tags de determinado video;UA.DETI.CBD- 2023/24 15

// 3. Todos os videos com a tag Aveiro;

// 4. Os ultimos 5 eventos de determinado video realizados por um utilizador;

// 5. Videos partilhados por determinado utilizador (maria1987, por exemplo) num determinado periodo de tempo (Agosto de 2017, por exemplo);

// 6. Os ultimos 10 videos, ordenado inversamente pela data da partilhada;

// 7. Todos os seguidores (followers) de determinado video;

// 8. Todos os comentarios (dos videos) que determinado utilizador esta a seguir (following);

// 9. Os 5 videos com maior rating;

// 10. Uma query que retorne todos os videos e que mostre claramente a forma pela qual estao ordenados;

// 11. Lista com as Tags existentes e o numero de videos catalogados com cada uma delas;

// 12.

// 13.
SELECT * FROM videotube.videos;