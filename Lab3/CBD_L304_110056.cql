CREATE KEYSPACE IF NOT EXISTS veiculos WITH replication = {'class': 'SimpleStrategy', 'replication_factor' : 1};
 
USE veiculos;

CREATE TABLE IF NOT EXISTS veiculos (
    id UUID PRIMARY KEY,
    nome text,
    marca text,
    motor text,
    detalhes set<text>,
    acessorios list<text>
);

CREATE TABLE IF NOT EXISTS marca (
    id UUID PRIMARY KEY,
    nome text,
    modelos_ano map<text, text>
);

CREATE TABLE IF NOT EXISTS motor (
    id UUID PRIMARY KEY,
    nome text,
    marca text
);

CREATE TABLE IF NOT EXISTS comentarios (
    veiculo_id UUID,
    comentario_id UUID,
    utilizador text,
    comentario text,
    timestamp timestamp,
    PRIMARY KEY (veiculo_id, comentario_id)
);

CREATE INDEX IF NOT EXISTS idx_comentarios_usuario ON comentarios (utilizador);


CREATE INDEX IF NOT EXISTS ON veiculos(marca);
CREATE INDEX IF NOT EXISTS ON veiculos(nome);
CREATE INDEX IF NOT EXISTS ON motor(marca);

INSERT INTO veiculos (id, nome, marca, motor, detalhes, acessorios) VALUES 
  (1, 'Modelo A', 'MarcaX', 'MotorX', {'Ar Condicionado', 'Direção Hidráulica'}, ['Rodas de Liga Leve', 'Sensor de Estacionamento']),
  (2, 'Modelo B', 'MarcaY', 'MotorY', {'ABS', 'Airbag'}, ['Teto Solar', 'Bancos de Couro']),
  (3, 'Modelo C', 'MarcaZ', 'MotorX', {'Câmera de Ré', 'Controle de Estabilidade'}, ['Kit Multimídia', 'Faróis de LED']);

INSERT INTO marca (id, nome, modelos_ano) VALUES 
  (1, 'MarcaX', {'Modelo A': '2022', 'Modelo C': '2023'}),
  (2, 'MarcaY', {'Modelo B': '2022'}),
  (3, 'MarcaZ', {'Modelo C': '2022'});

INSERT INTO motor (id, nome, marca) VALUES 
  (1, 'MotorX', 'MarcaX'),
  (2, 'MotorY', 'MarcaY');
  
INSERT INTO detalhes_veiculo (veiculo_id, detalhe) VALUES
  (1, 'Bluetooth'),
  (1, 'Sensor de Chuva'),
  (2, 'Controle de Tração'),
  (3, 'Vidros Elétricos');

INSERT INTO acessorios_veiculo (veiculo_id, indice, acessorio) VALUES
  (1, 1, 'Engate'),
  (1, 2, 'Rodas de Liga Leve'),
  (2, 1, 'Teto Solar'),
  (3, 1, 'Kit Multimídia');