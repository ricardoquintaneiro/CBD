
CREATE KEYSPACE IF NOT EXISTS cbd WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};
 
USE cbd;

CREATE TABLE utilizadores (
    id uuid,
    username text,
    nome text,
    email text,
    timestamp timestamp,
    PRIMARY KEY (id)
);

CREATE TABLE videos (
    id uuid,
    autor uuid,
    nome text,
    descricao text,
    tags set<text>,
    timestamp timestamp,
    PRIMARY KEY (autor, timestamp, id)
);

CREATE TABLE comentarios_por_utilizador (
    id uuid,
    autor uuid,
    video uuid,
    texto text,
    timestamp timestamp,
    PRIMARY KEY (autor, timestamp, id)
);

CREATE TABLE comentarios_por_video (
    id uuid,
    autor uuid,
    video uuid,
    texto text,
    timestamp timestamp,
    PRIMARY KEY (video, timestamp, id)
);

CREATE TABLE seguidores_video (
    video uuid,
    seguidores set<uuid>,
    PRIMARY KEY (video)
);

CREATE TABLE eventos (
    id uuid,
    tipo text,
    autor uuid,
    video uuid,
    timestamp timestamp,
    video_time duration,
    PRIMARY KEY (video, timestamp, id)
);

CREATE TABLE ratings_video (
    video uuid,
    rating tinyint,
    id uuid, 
    PRIMARY KEY (video, rating, id)
);


