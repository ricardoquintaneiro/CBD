
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
    PRIMARY KEY (id)
);

CREATE TABLE comentarios (
    id uuid,
    autor uuid,
    video uuid,
    texto text,
    timestamp timestamp,
    PRIMARY KEY (id)
);

CREATE TABLE seguidores_video (
    id uuid,
    seguidores set<uuid>,
    video uuid,
    PRIMARY KEY (id)
);

CREATE TABLE eventos (
    id uuid,
    tipo text,
    autor uuid,
    video uuid,
    timestamp timestamp,
    video_time duration,
    PRIMARY KEY (id)
);

CREATE TABLE ratings_video (
    video uuid,
    ratings list<tinyint>,
    PRIMARY KEY (video)
);

CREATE INDEX ON comentarios (autor);
CREATE INDEX ON comentarios (video);