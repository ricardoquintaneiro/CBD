USE cbd;

// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (bc6bfa83-fa8b-4c79-a5f8-15db531e1342, 'jluis', 'João Luís', 'jluis@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (75547b5f-f305-494f-8eac-a63b5529c2dc, 'zgameiro', 'Zé Gameiro', 'zgameiro@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (5a3ff930-e689-4cb9-b552-0e8f63facf93, 'marcelo', 'Marcelo Rebelo', 'marcelo@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (60b47b2a-af23-43ad-9e1e-3b3c6419a246, 'costa', 'António Costa', 'costa@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (4a9fec76-4d4a-473f-9fc4-7f37b15daad0, 'fmendes', 'Fernando Mendes', 'fmendes@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (0aee4739-3d74-430b-be8f-542a91990d9f, 'cris', 'Cristiano Ronaldo', 'cris@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (93103193-1b3e-46aa-96e9-f2caebd29475, 'ricfazeres', 'Ric Fazeres', 'ricfazeres@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (70dd0f2f-1c2d-452a-9fbf-91096b421c74, 'gyokeres', 'Viktor Gyokeres', 'gyokeres@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (7f60ecc8-577a-480b-adbc-6340b032e32f, 'zeca', 'Zeca Estacionâncio', 'zeca@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (d5d0d395-4ba3-447b-ba61-bd5221d6648b, 'quim', 'Quim Roscas', 'quim@example.com', toTimestamp(now()));
// INSERT INTO utilizadores(id, username, nome, email, timestamp) VALUES (2271940c-011e-4601-aeef-7a784204b0d6, 'dartacao', 'Dartacão', 'dartacao@example.com', toTimestamp(now()));
//
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (e88b714b-5cd8-40dd-b629-fb9b1503c578, bc6bfa83-fa8b-4c79-a5f8-15db531e1342, 'O balão do João', 'Ensino a encher balão.', {'Ensino', 'Infantil'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (3bf25d85-2cf3-4809-80d2-8f60207b55fc, 93103193-1b3e-46aa-96e9-f2caebd29475, 'Ric the Barrigas no UFC', 'Vai-te encher da moscas', {'Gaming', 'Luta'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (e77103d3-500e-43a0-9eac-09bbaba8d898, 7f60ecc8-577a-480b-adbc-6340b032e32f, 'Quim Roscas e Zeca Estacionâncio DVD 2007', 'PUUUUBLIIICIIIDAAADE', {'Comédia', '+18'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (58e90b21-495a-4c93-811b-91c3a227eb7c, 5a3ff930-e689-4cb9-b552-0e8f63facf93, 'Como ser Presidente do Povo', 'Neste vídeo eu ensino a ser Presidente dos afetos.', {'Política', 'Ensino'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (50e82c49-8486-484c-843d-c57783ecde36, 4a9fec76-4d4a-473f-9fc4-7f37b15daad0, 'Preço Certo - Melhores momentos', 'Melhores momentos do Preço Certo desde sempre.', {'Comédia', 'RTP1', 'Highlights'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (d703a0f1-8a28-4696-a6f1-596ae377745a, 2271940c-011e-4601-aeef-7a784204b0d6, 'Dartacão e os Três Mosqueteiros', 'Série completa', {'Desenhos Animados', 'Infantil'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (40e4b650-c3a1-4716-904d-2e4187ba9c6f, 70dd0f2f-1c2d-452a-9fbf-91096b421c74, 'Highlights Gyokeres - Sporting', '2023/2024 season highlights', {'Desporto', 'Highlights'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (32966120-dac7-4952-a0ad-2143dea59e3b, 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 'Expondo o ministro Galamba', 'O porquê de eu aguentar com ele durante tanto tempo.', {'Política'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (faee0265-8ee8-405d-874a-19912f7be174, 75547b5f-f305-494f-8eac-a63b5529c2dc, 'Ranking de músicas do António Variações', 'O meu artista favorito.', {'Música', 'Ranking'}, toTimestamp(now()));
// INSERT INTO videos(id, autor, nome, descricao, tags, timestamp) VALUES (610af74f-90c5-4a57-a602-b7e43616f2b8, 0aee4739-3d74-430b-be8f-542a91990d9f, 'Melhores golos do Cris', 'Compilação dos melhores golos de Cristiano Ronaldo.', {'Desporto', 'Highlights'}, toTimestamp(now()));
 

// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (c9db4a9c-baeb-463e-aa34-186cc94a4588, 0aee4739-3d74-430b-be8f-542a91990d9f, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'O meu Presidente!!! Grande abraço!', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (8300c9e4-35c6-4e86-9d70-0134a56b740b, 5a3ff930-e689-4cb9-b552-0e8f63facf93, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'Querem sequela? :D', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (97332677-9bcb-4ec0-8985-197579cbeeef, 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 58e90b21-495a-4c93-811b-91c3a227eb7c, 'Gostei bastante.', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (b4b85610-7d6b-44ec-8eca-d89d66369874, 5a3ff930-e689-4cb9-b552-0e8f63facf93, 50e82c49-8486-484c-843d-c57783ecde36, 'Ri-me muito ahah', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (46db92e4-3c08-4c96-a109-419c7f476819, 75547b5f-f305-494f-8eac-a63b5529c2dc, e88b714b-5cd8-40dd-b629-fb9b1503c578, 'Obrigado grande amigo João Luís!', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (a2282e47-262e-4de6-b2d0-422d3b0f393a, 0aee4739-3d74-430b-be8f-542a91990d9f, 3bf25d85-2cf3-4809-80d2-8f60207b55fc, 'Ganda Ric!!! Abraço!', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (1efdb0b7-1a36-4a25-9b97-c6b97c0d08b7, 0aee4739-3d74-430b-be8f-542a91990d9f, e88b714b-5cd8-40dd-b629-fb9b1503c578, 'Usei o teu vídeo para ensinar o Cristianinho! Obrigadão!', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (149099f0-3e2e-44f9-bf07-7c63f05f42bb, 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 75547b5f-f305-494f-8eac-a63b5529c2dc, 'A melhor coletânea do Youtube.', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (3b58a2e6-49d3-427e-8623-aab7f78f945f, d5d0d395-4ba3-447b-ba61-bd5221d6648b, e77103d3-500e-43a0-9eac-09bbaba8d898, 'Aí o outro é bastante engraçado', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (0c4ec4b7-d96f-4008-889d-2959c0d1c1aa, 0aee4739-3d74-430b-be8f-542a91990d9f, 2271940c-011e-4601-aeef-7a784204b0d6, 'O Enzo gostou muito do Dartacão :D', toTimestamp(now()));
// INSERT INTO comentarios(id, autor, video, texto, timestamp) VALUES (972278cf-52f2-4d39-8e8c-1640a358f857, 70dd0f2f-1c2d-452a-9fbf-91096b421c74, 610af74f-90c5-4a57-a602-b7e43616f2b8, 'Tu és a minha inspiração!', toTimestamp(now()));



// INSERT INTO seguidores_video(id, video, seguidores) VALUES (fa3f712c-c795-465b-9dbb-57e27f5300ca, e88b714b-5cd8-40dd-b629-fb9b1503c578, {0aee4739-3d74-430b-be8f-542a91990d9f, 75547b5f-f305-494f-8eac-a63b5529c2dc, bc6bfa83-fa8b-4c79-a5f8-15db531e1342});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (4a9f1396-2698-4c5f-ac4b-123ee54c1b52, 3bf25d85-2cf3-4809-80d2-8f60207b55fc, {0aee4739-3d74-430b-be8f-542a91990d9f, 93103193-1b3e-46aa-96e9-f2caebd29475});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (2f7ae256-0e8d-4e7f-be40-7b6e085fc836, e77103d3-500e-43a0-9eac-09bbaba8d898, {7f60ecc8-577a-480b-adbc-6340b032e32f, d5d0d395-4ba3-447b-ba61-bd5221d6648b});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (5340e697-ed0f-4eb8-b112-086a4b763154, 58e90b21-495a-4c93-811b-91c3a227eb7c, {5a3ff930-e689-4cb9-b552-0e8f63facf93, 60b47b2a-af23-43ad-9e1e-3b3c6419a246});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (b1101e64-b74c-4e3c-8cda-cacd7d319ff9, 50e82c49-8486-484c-843d-c57783ecde36, {4a9fec76-4d4a-473f-9fc4-7f37b15daad0, 5a3ff930-e689-4cb9-b552-0e8f63facf93});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (c2f0420c-ed3b-4429-98e1-694481cfc9b4, d703a0f1-8a28-4696-a6f1-596ae377745a, {2271940c-011e-4601-aeef-7a784204b0d6, 0aee4739-3d74-430b-be8f-542a91990d9f});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (f3d4742f-5d1d-4db5-aed9-73e218243c62, 40e4b650-c3a1-4716-904d-2e4187ba9c6f, {70dd0f2f-1c2d-452a-9fbf-91096b421c74, 0aee4739-3d74-430b-be8f-542a91990d9f});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (653121cc-4ee0-4919-b90b-75bb4fe888ea, 32966120-dac7-4952-a0ad-2143dea59e3b, {60b47b2a-af23-43ad-9e1e-3b3c6419a246, 5a3ff930-e689-4cb9-b552-0e8f63facf93});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (6d9da3e5-719c-4152-863e-ec42a7d30dc7, faee0265-8ee8-405d-874a-19912f7be174, {75547b5f-f305-494f-8eac-a63b5529c2dc, bc6bfa83-fa8b-4c79-a5f8-15db531e1342});
// INSERT INTO seguidores_video(id, video, seguidores) VALUES (acf9ee39-ccd2-41a0-8bd3-86c9192d5fa0, 610af74f-90c5-4a57-a602-b7e43616f2b8, {0aee4739-3d74-430b-be8f-542a91990d9f, 70dd0f2f-1c2d-452a-9fbf-91096b421c74});


// INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (6b73c07d-69d6-4e9f-a172-16691106f209, 'play', 0aee4739-3d74-430b-be8f-542a91990d9f, 610af74f-90c5-4a57-a602-b7e43616f2b8, toTimestamp(now()), 2s);
// INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (ecd4df07-8a88-41e0-bda4-b41f53ed153b, 'pause', 0aee4739-3d74-430b-be8f-542a91990d9f, 610af74f-90c5-4a57-a602-b7e43616f2b8, toTimestamp(now()), 40s);
// INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (49d9d417-3d60-41a0-8a63-50b012dba0aa, 'play', 0aee4739-3d74-430b-be8f-542a91990d9f, 610af74f-90c5-4a57-a602-b7e43616f2b8, toTimestamp(now()), 40s);
// INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (221358f9-1943-46cf-9b93-add7e931f304, 'stop', 0aee4739-3d74-430b-be8f-542a91990d9f, 610af74f-90c5-4a57-a602-b7e43616f2b8, toTimestamp(now()), 300s);
// INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (851911ad-b731-438d-a6d7-3f20cc75137d, 'play', 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 58e90b21-495a-4c93-811b-91c3a227eb7c, toTimestamp(now()), 0s);
// INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (265b08cc-8ab4-4e1c-9857-d19fc1ac66ef, 'stop', 60b47b2a-af23-43ad-9e1e-3b3c6419a246, 58e90b21-495a-4c93-811b-91c3a227eb7c, toTimestamp(now()), 90s);

INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (uuid(), 'play', 75547b5f-f305-494f-8eac-a63b5529c2dc, e88b714b-5cd8-40dd-b629-fb9b1503c578, toTimestamp(now()), 2s);
INSERT INTO eventos(id, tipo, autor, video, timestamp, video_time) VALUES (uuid(), 'stop', 75547b5f-f305-494f-8eac-a63b5529c2dc, e88b714b-5cd8-40dd-b629-fb9b1503c578, toTimestamp(now()), 3m50s);

