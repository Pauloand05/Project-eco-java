-- Script 6: Inserção de denúncias de exemplo

INSERT INTO denuncia (titulo, descricao, usuario_cpf, endereco_cep, status, anonima) VALUES
('Descarte irregular de lixo na Avenida Paulista', 
 'Encontrei um grande volume de lixo descartado irregularmente próximo ao córrego que passa pela Avenida Paulista. O lixo inclui restos de construção, móveis velhos e lixo doméstico. O odor está muito forte e pode estar contaminando o curso d''água.',
 '123.456.789-01', '01310-100', 'resolvida', FALSE),

('Poluição sonora em estabelecimento comercial',
 'Estabelecimento na Rua Augusta com música alta após as 22h, perturbando moradores da região. O problema ocorre principalmente nos finais de semana e já foi reportado várias vezes aos proprietários sem sucesso.',
 '234.567.890-12', '01414-001', 'em_analise', TRUE),

('Desmatamento em área protegida',
 'Observei atividade de desmatamento em área que acredito ser de preservação próxima ao Parque do Ibirapuera. Várias árvores foram cortadas sem autorização aparente e há sinais de queimada no local.',
 '345.678.901-23', '04038-001', 'pendente', FALSE),

('Vazamento de óleo em via pública',
 'Há um vazamento de óleo de veículo que está se espalhando pela via pública na Rua Funchal. O vazamento já dura mais de uma semana e está criando uma mancha que pode contaminar o solo e ser perigosa para pedestres.',
 '456.789.012-34', '04038-001', 'em_analise', FALSE),

('Maus-tratos a animais em pet shop',
 'Presenciei situações de maus-tratos a animais em um pet shop na região dos Jardins. Os animais estão em condições precárias, sem água limpa e em espaços muito pequenos. Gostaria que fosse feita uma fiscalização.',
 '567.890.123-45', '01452-000', 'pendente', TRUE),

('Poluição do ar por queima de lixo',
 'Moradores de um terreno baldio estão queimando lixo regularmente, causando poluição do ar e mau cheiro na região. A fumaça está afetando a qualidade do ar e pode ser prejudicial à saúde dos moradores próximos.',
 '678.901.234-56', '05407-002', 'resolvida', FALSE),

('Descarte inadequado de produtos químicos',
 'Uma empresa está descartando produtos químicos de forma inadequada em um terreno próximo à Avenida Berrini. O solo está com coloração estranha e há um odor químico forte no local.',
 '789.012.345-67', '04567-001', 'em_analise', FALSE);
