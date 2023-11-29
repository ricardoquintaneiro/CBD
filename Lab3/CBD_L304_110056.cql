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
    PRIMARY KEY (id, marca, nome)
);

CREATE TABLE IF NOT EXISTS comentarios (
    veiculo_id UUID,
    comentario_id UUID,
    utilizador text,
    comentario text,
    timestamp timestamp,
    PRIMARY KEY (veiculo_id, timestamp, comentario_id)
);


CREATE INDEX IF NOT EXISTS ON veiculos(marca);
CREATE INDEX IF NOT EXISTS ON motor(marca);
CREATE INDEX IF NOT EXISTS ON comentarios (utilizador);



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


INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), '458 Italia', 'Ferrari', 'F142', 2022, {'Faróis de LED', 'Couro Alcantara'}, {'Sistema de Navegação': 2, 'Controle de Tração': 1}, ['2020-01-02', toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), '488 Pista', 'Ferrari', 'F154', 2023, {'Sistema de Escape Esportivo', 'Pneus de Alta Performance'}, {'Câmera de Ré': 1, 'Interior de Fibra de Carbono': 3}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'Huracan Evo', 'Lamborghini', 'LV10', 2021, {'Faróis Full LED', 'Estofamento em Couro'}, {'Rodas Forjadas': 2, 'Sistema de Som Premium': 2}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'Aventador SVJ', 'Lamborghini', 'LV12', 2022, {'Spoiler Traseiro Ativo', 'Capota Removível'}, {'Pintura Metálica': 1, 'Sistema de Freios Cerâmicos': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), '911 GT3', 'Porsche', 'PH6', 2023, {'Bancos Esportivos', 'Teto Solar'}, {'Pacote Chrono': 3, 'Assistência de Estacionamento': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'Taycan', 'Porsche', 'PElectric', 2021, {'Sistema de Som Burmester', 'Carregamento Rápido'}, {'Teto Solar Panorâmico': 2, 'Assistência de Condução': 2}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'A6', 'Audi', 'AV6', 2022, {'Bancos de Couro', 'Ar Condicionado Dual Zone'}, {'Sistema de Navegação MMI': 1, 'Assistência de Ponto Cego': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'Q7', 'Audi', 'AV6', 2023, {'Teto Solar Panorâmico', 'Faróis de Xenônio'}, {'Bancos Aquecidos': 2, 'Câmera de Visão 360°': 3}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'M3', 'BMW', 'S58', 2021, {'Rodas de Liga Leve', 'Estofamento em Couro Sintético'}, {'Sistema de Som Harman Kardon': 1, 'Pacote de Iluminação Ambiente': 2}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'X5', 'BMW', 'B58', 2022, {'Bancos Elétricos com Memória', 'Teto Solar Panorâmico'}, {'Sistema de Entretenimento Traseiro': 2, 'Assistência de Condução Avançada': 1}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'CLS 53', 'Mercedes', 'M256', 2023, {'Bancos Esportivos', 'Câmbio Automático 9G-TRONIC'}, {'Head-Up Display': 1, 'Suspensão Pneumática': 3}, [toTimestamp(now())]);
INSERT INTO veiculos (id, nome, marca, motor, ano, detalhes, acessorios_e_qtd, datas_revisoes) VALUES
  (uuid(), 'GLE Coupe', 'Mercedes', 'M264', 2021, {'Sistema de Escape Esportivo', 'Assistência de Estacionamento'}, {'Câmera 360°': 3, 'Bancos Ventilados': 2}, [toTimestamp(now())]);


INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'F142', 'Ferrari');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'F154', 'Ferrari');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'LV10', 'Lamborghini');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'LV12', 'Lamborghini');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'PH6', 'Porsche');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'PElectric', 'Porsche');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'AV6', 'Audi');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'S58', 'BMW');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'B58', 'BMW');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'M256', 'Mercedes');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'M264', 'Mercedes');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'V8 Coyote', 'Ford');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'EcoBoost', 'Ford');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'LT1', 'Chevrolet');
INSERT INTO motores (id, nome, marca) VALUES (uuid(), 'LS7', 'Chevrolet');


INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user1', 'Great car!', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user2', 'Love the design.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user3', 'Incredible speed!', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user4', 'Amazing color options.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user5', 'Excellent handling.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user6', 'Top-notch performance.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user7', 'Luxurious interior.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user8', 'Smooth ride.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user9', 'Sporty look.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user10', 'Efficient fuel consumption.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user11', 'Comfortable seats.', toTimestamp(now()));
INSERT INTO comentarios (veiculo_id, comentario_id, utilizador, comentario, timestamp) VALUES (uuid(), uuid(), 'user12', 'Impressive safety features.', toTimestamp(now()));

