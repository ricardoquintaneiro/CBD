CREATE KEYSPACE IF NOT EXISTS veiculos WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};
 
USE veiculos;

CREATE TABLE IF NOT EXISTS marcas (
    nome text,
    nacionalidade text,
    data_fundacao timestamp,
    PRIMARY KEY (nome)
);
 
CREATE TABLE IF NOT EXISTS veiculos (
    id UUID,
    nome text,
    marca text,
    motor text,
    ano int,
    detalhes set<text>,
    acessorios_e_qtd map<text, int>,
    datas_revisoes list<timestamp>,
    PRIMARY KEY (id, marca, nome)
) WITH CLUSTERING ORDER BY (marca ASC, nome ASC);

CREATE TABLE IF NOT EXISTS motores (
    id UUID,
    nome text,
    marca text,
    cilindros tinyint,
    PRIMARY KEY (id, marca, nome)
);

CREATE TABLE IF NOT EXISTS comentarios (
    veiculo_id UUID,
    comentario_id UUID,
    comentario text,
    timestamp timestamp,
    PRIMARY KEY (veiculo_id, timestamp, comentario_id)
);


CREATE INDEX IF NOT EXISTS ON veiculos(marca);
CREATE INDEX IF NOT EXISTS ON veiculos(detalhes);
CREATE INDEX IF NOT EXISTS ON motores(marca);


INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Ferrari', 'Itália', '1939-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Lamborghini', 'Itália', '1963-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Porsche', 'Alemanha', '1931-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Audi', 'Alemanha', '1909-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('BMW', 'Alemanha', '1916-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Mercedes', 'Alemanha', '1926-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Volkswagen', 'Alemanha', '1937-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Ford', 'EUA', '1903-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Chevrolet', 'EUA', '1911-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Dodge', 'EUA', '1900-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Tesla', 'EUA', '2003-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Toyota', 'Japão', '1937-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Honda', 'Japão', '1946-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Nissan', 'Japão', '1933-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Mitsubishi', 'Japão', '1870-01-01');
INSERT INTO marcas (nome, nacionalidade, data_fundacao) VALUES ('Bugatti', 'Francesa', '1909-01-15');


INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (7f7aefe5-bfd1-45a7-b18e-a930d9097ed5, '458 Italia', 'Ferrari', 'F142', 2022, {'Faróis de LED', 'Couro Alcantara'}, {'Sistema de Navegação': 2, 'Controle de Tração': 1}, ['2020-01-02', toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (92a49643-4eb3-416a-a529-0196b8436e97, '488 Pista', 'Ferrari', 'F154', 2023, {'Sistema de Escape Esportivo', 'Pneus de Alta Performance'}, {'Câmera de Ré': 1, 'Interior de Fibra de Carbono': 3}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (6b99ff7b-a437-4860-af5b-80b859ba6349, 'Huracan Evo', 'Lamborghini', 'LV10', 2021, {'Faróis Full LED', 'Estofamento em Couro'}, {'Rodas Forjadas': 2, 'Sistema de Som Premium': 2}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (1ee28dae-0e67-4a49-8f40-458c97d4dbbd, 'Aventador SVJ', 'Lamborghini', 'LV12', 2022, {'Spoiler Traseiro Ativo', 'Capota Removível'}, {'Pintura Metálica': 1, 'Sistema de Freios Cerâmicos': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (70779a6c-4fee-4cac-85b5-4eacd6caebcc, '911 GT3', 'Porsche', 'PH6', 2023, {'Bancos Esportivos', 'Teto Solar'}, {'Pacote Chrono': 3, 'Assistência de Estacionamento': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (79734616-ee38-42e9-af8a-9892ce2607f9, 'Taycan', 'Porsche', 'PElectric', 2021, {'Sistema de Som Burmester', 'Carregamento Rápido'}, {'Teto Solar Panorâmico': 2, 'Assistência de Condução': 2}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (6f0a83fd-0d6d-451d-be41-9fdf40920348, 'A6', 'Audi', 'AV6', 2022, {'Bancos de Couro', 'Ar Condicionado Dual Zone'}, {'Sistema de Navegação MMI': 1, 'Assistência de Ponto Cego': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (f2c07d9b-8bb1-4506-a05f-3005349d2dd3, 'Q7', 'Audi', 'AV6', 2023, {'Teto Solar Panorâmico', 'Faróis de LED'}, {'Bancos Aquecidos': 2, 'Câmera de Visão 360°': 3}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (aab27c8e-9b06-4401-9faf-d14c44ca6e85, 'M3', 'BMW', 'S58', 2021, {'Rodas de Liga Leve', 'Estofamento em Couro Sintético'}, {'Sistema de Som Harman Kardon': 1, 'Pacote de Iluminação Ambiente': 2}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (5d85b678-fe44-4904-8fb6-dbbd50570913, 'X5', 'BMW', 'B58', 2022, {'Bancos Elétricos com Memória', 'Teto Solar Panorâmico'}, {'Sistema de Entretenimento Traseiro': 2, 'Assistência de Condução Avançada': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (c394f005-0416-423f-958d-c4c19c121f97, 'CLS 53', 'Mercedes', 'M256', 2023, {'Bancos Esportivos', 'Câmbio Automático 9G-TRONIC'}, {'Head-Up Display': 1, 'Suspensão Pneumática': 3}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (f1f4b8e7-e6a8-451e-b4d0-d2fc9c24b30c, 'GLE Coupe', 'Mercedes', 'M264', 2021, {'Sistema de Escape Esportivo', 'Assistência de Estacionamento'}, {'Câmera 360°': 3, 'Bancos Ventilados': 2}, [toTimestamp(now())]);


INSERT INTO motores (id, nome, marca, cilindros) VALUES (1326c864-e75b-422f-8e5d-62cfba12c7a1, 'F142', 'Ferrari', 8);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (57fdbb90-872d-4a27-aee5-e5ad3230d98c, 'F154', 'Ferrari', 8);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (0bc2b31a-3847-447f-a797-0609f3c3e2bc, 'LV10', 'Lamborghini', 10);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (f3bd4b54-c5eb-482d-b97e-27e231d853c6, 'LV12', 'Lamborghini', 12);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (f8b992e2-2500-47e5-bd6d-43ebfd28cae1, 'PH6', 'Porsche', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (2dccbf8d-bf85-4d83-9ae2-a418535607fd, 'PElectric', 'Porsche', 0);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (adcbc422-6f17-44c0-b497-1d35bfb5c2c3, 'AV6', 'Audi', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (1630934c-eff6-455f-a7c1-9948bc553e39, 'S58', 'BMW', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (2bed1ab6-8ed5-40d8-b476-bbc6575d78e0, 'B58', 'BMW', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (5b24f887-97e1-4158-8def-54caf60929f9, 'M256', 'Mercedes', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (0c46df21-88f8-4f9c-81a5-e65c0682401d, 'M264', 'Mercedes', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (e381474d-3d31-4c80-91df-9c8093702b09, 'V8 Coyote', 'Ford', 8);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (c7dfdf97-910a-4c66-ad9a-520111db91fa, 'EcoBoost', 'Ford', 6);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (f9b10c57-24e6-40f9-8fdc-12bc3ce03325, 'LT1', 'Chevrolet', 8);
INSERT INTO motores (id, nome, marca, cilindros) VALUES (bf561650-65e9-43d0-ac39-626747cd01d0, 'LS7', 'Chevrolet', 8);

 
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (7f7aefe5-bfd1-45a7-b18e-a930d9097ed5, ab13b951-dc4b-489a-a9be-2a532b5f1e4d, 'Great car!', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (92a49643-4eb3-416a-a529-0196b8436e97, d6e4b61a-5139-4a17-9556-4a29d4f8bf68, 'Love the design.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (6b99ff7b-a437-4860-af5b-80b859ba6349, cefa57d3-d7c1-4e1f-bdfb-326ff5392199, 'Incredible speed!', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (1ee28dae-0e67-4a49-8f40-458c97d4dbbd, 4e89502c-1cb0-440f-9d56-d4045ad0831d, 'Amazing color options.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (70779a6c-4fee-4cac-85b5-4eacd6caebcc, 49d87135-998a-4f27-8703-f5d2773d8bd3, 'Excellent handling.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (79734616-ee38-42e9-af8a-9892ce2607f9, b6b4f0b5-4afb-43a8-a1a8-ea0048cc6763, 'Top-notch performance.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (6f0a83fd-0d6d-451d-be41-9fdf40920348, 7029b7e3-bea6-4a69-8df5-1e8a7f98bf8f, 'Luxurious interior.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (f2c07d9b-8bb1-4506-a05f-3005349d2dd3, 2300b898-b4e2-4a8b-9d8c-8745bb24394d, 'Smooth ride.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (aab27c8e-9b06-4401-9faf-d14c44ca6e85, d036c185-563c-4660-b8cb-a6ebd628c9f9, 'Sporty look.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (5d85b678-fe44-4904-8fb6-dbbd50570913, 0e2fa5a8-2485-438e-af48-799e2b08912f, 'Efficient fuel consumption.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (c394f005-0416-423f-958d-c4c19c121f97, 9ab03808-edfc-4469-bbde-8c4e108d3eef, 'Comfortable seats.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (f1f4b8e7-e6a8-451e-b4d0-d2fc9c24b30c, 8f6eea23-847d-4f7f-88bc-e3316b17a4e0, 'Impressive safety features.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, comentario, timestamp) VALUES (aab27c8e-9b06-4401-9faf-d14c44ca6e85, 19efe2f3-e719-48e0-9228-4eff05786e2e, 'Incredible BMW Motorsport power.', toTimestamp(now()));


UPDATE veiculos SET detalhes = {'Bancos de couro', 'Teto-de-abrir'} WHERE id = 6f0a83fd-0d6d-451d-be41-9fdf40920348 and marca='Audi' and nome='A6';
UPDATE veiculos SET acessorios_e_qtd['GPS System'] = 4 WHERE id = 6f0a83fd-0d6d-451d-be41-9fdf40920348 and marca='Audi' and nome='A6';
UPDATE veiculos SET datas_revisoes = datas_revisoes + ['2023-02-01'] WHERE id = 6b99ff7b-a437-4860-af5b-80b859ba6349 and marca='Lamborghini' and nome='Huracan Evo';
UPDATE marcas SET nacionalidade = 'França' WHERE nome = 'Bugatti';
UPDATE motores SET cilindros = NULL WHERE id = 2dccbf8d-bf85-4d83-9ae2-a418535607fd and marca='Porsche' and nome='PElectric';
UPDATE veiculos SET detalhes = detalhes - {'Teto-de-abrir'} WHERE id = 6f0a83fd-0d6d-451d-be41-9fdf40920348 and marca='Audi' and nome='A6';
UPDATE veiculos SET acessorios_e_qtd = acessorios_e_qtd - {'GPS System'} WHERE id = 6f0a83fd-0d6d-451d-be41-9fdf40920348 and marca='Audi' and nome='A6';
UPDATE veiculos SET datas_revisoes = datas_revisoes - ['2023-02-01'] WHERE id = 6b99ff7b-a437-4860-af5b-80b859ba6349 and marca='Lamborghini' and nome='Huracan Evo';
DELETE FROM marcas WHERE nome = 'Mitsubishi';
DELETE FROM motores WHERE id = c7dfdf97-910a-4c66-ad9a-520111db91fa;
DELETE FROM comentarios WHERE veiculo_id = f2c07d9b-8bb1-4506-a05f-3005349d2dd3 AND timestamp = '2023-11-29 22:46:38.383000+0000' AND comentario_id = 2300b898-b4e2-4a8b-9d8c-8745bb24394d;
DELETE FROM veiculos WHERE id = f1f4b8e7-e6a8-451e-b4d0-d2fc9c24b30c;
DELETE FROM marcas WHERE nome = 'Nissan';




// Selecionar nomes e datas de fundação das marcas
SELECT nome, data_fundacao FROM marcas;

// Seleciona os detalhes e acessórios, juntamente com as suas quantidades, de um veículo específico
SELECT detalhes, acessorios_e_qtd FROM veiculos WHERE id = 6f0a83fd-0d6d-451d-be41-9fdf40920348;

// Seleciona os nomes dos motores de todas as marcas que têm 8 ou mais cilindros.
SELECT nome FROM motores WHERE cilindros >= 8 ALLOW FILTERING;

// Seleciona a marca, nome e cilindros de um motor específico
SELECT marca, nome, cilindros FROM motores WHERE id = f8b992e2-2500-47e5-bd6d-43ebfd28cae1;

// Seleciona os comentários associados a um veículo específico
SELECT comentario FROM comentarios WHERE veiculo_id = 6f0a83fd-0d6d-451d-be41-9fdf40920348;

// Seleciona a marca e o nome dos veículos da marca 'Ferrari'
SELECT marca, nome FROM veiculos WHERE marca='Ferrari';

// Seleciona a marca, nome e detalhes dos veículos que contêm 'Faróis de LED' nos seus detalhes.
SELECT marca, nome, detalhes FROM veiculos WHERE detalhes CONTAINS 'Faróis de LED';

// Calcula a média dos anos dos veículos
SELECT AVG(ano) FROM veiculos;

// Calcula a média dos cilindros dos motores
SELECT AVG(cilindros) AS average_cilindros FROM motores;

// Seleciona o comentário mais recente associado a um veículo específico
SELECT * FROM comentarios WHERE veiculo_id = aab27c8e-9b06-4401-9faf-d14c44ca6e85 ORDER BY timestamp DESC LIMIT 1;

// Seleciona todos os campos dos motores associados à marca 'BMW'
SELECT * FROM motores WHERE marca = 'BMW';
 