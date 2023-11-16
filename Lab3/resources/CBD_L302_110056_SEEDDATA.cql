USE cbd;

// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'jluis', 'João Luís', 'jluis@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'zgameiro', 'Zé Gameiro', 'zgameiro@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'marcelo', 'Marcelo Rebelo', 'marcelo@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'costa', 'António Costa', 'costa@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'fmendes', 'Fernando Mendes', 'fmendes@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'cris', 'Cristiano Ronaldo', 'cris@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'ricfazeres', 'Ric Fazeres', 'ricfazeres@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'gyokeres', 'Viktor Gyokeres', 'gyokeres@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'zeca', 'Zeca Estacionâncio', 'zeca@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'quim', 'Quim Roscas', 'quim@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (uuid(), 'dartacao', 'Dartacão', 'dartacao@example.com', toTimestamp(now()));
 
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), bc6bfa83-fa8b-4c79-a5f8-15db531e1342, 'O balão do João', 'Ensino a encher balão.', {'Ensino', 'Infantil'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 93103193-1b3e-46aa-96e9-f2caebd29475, 'Ric the Barrigas no UFC', 'Vai-te encher da moscas', {'Gaming', 'Luta'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 7f60ecc8-577a-480b-adbc-6340b032e32f, 'Quim Roscas e Zeca Estacionâncio DVD 2007', 'PUUUUBLIIICIIIDAAADE', {'Comédia', '+18'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 5a3ff930-e689-4cb9-b552-0e8f63facf93, 'Como ser Presidente do Povo', 'Neste vídeo eu ensino a ser Presidente dos afetos.', {'Política', 'Ensino'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 4a9fec76-4d4a-473f-9fc4-7f37b15daad0, 'Preço Certo - Melhores momentos', 'Melhores momentos do Preço Certo desde sempre.', {'Comédia', 'RTP1', 'Highlights'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 2271940c-011e-4601-aeef-7a784204b0d6, 'Dartacão e os Três Mosqueteiros', 'Série completa', {'Desenhos Animados', 'Infantil'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 70dd0f2f-1c2d-452a-9fbf-91096b421c74, 'Highlights Gyokeres - Sporting', '2023/2024 season highlights', {'Desporto', 'Infantil', 'Highlights'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 'Expondo o ministro Galamba', 'O porquê de eu aguentar com ele durante tanto tempo.', {'Política'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 75547b5f-f305-494f-8eac-a63b5529c2dc, 'Ranking de músicas do António Variações', 'O meu artista favorito.', {'Música', 'Ranking'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 'Melhores golos do Cris', 'Compilação dos melhores golos de Cristiano Ronaldo.', {'Desporto', 'Highlights'}, toTimestamp(now()));
 

INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 5a3ff930-e689-4cb9-b552-0e8f63facf93, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'Querem sequela? :D', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'Gostei bastante.', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 5a3ff930-e689-4cb9-b552-0e8f63facf93, 50e82c49-8486-484c-843d-c57783ecde36, 'Ri-me muito ahah', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 75547b5f-f305-494f-8eac-a63b5529c2dc, e88b714b-5cd8-40dd-b629-fb9b1503c578, 'Obrigado grande amigo João Luís!', toTimestamp(now()));
 
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 50e82c49-8486-484c-843d-c57783ecde36, '', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (uuid(), 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));