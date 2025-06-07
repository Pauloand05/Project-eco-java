-- Script 10: Inserção de horários de coleta

INSERT INTO horarios_coleta (dia_semana, turno, endereco_cep) VALUES
-- Segunda-feira (1)
(1, 'manha', '01310-100'),
(1, 'manha', '04038-001'),
(1, 'tarde', '05407-002'),
(1, 'tarde', '01414-001'),

-- Terça-feira (2)
(2, 'manha', '04094-050'),
(2, 'manha', '01327-001'),
(2, 'tarde', '05508-010'),
(2, 'tarde', '04567-001'),

-- Quarta-feira (3)
(3, 'manha', '01452-000'),
(3, 'manha', '02071-000'),
(3, 'tarde', '03102-000'),
(3, 'tarde', '05001-000'),

-- Quinta-feira (4)
(4, 'manha', '08540-000'),
(4, 'manha', '04038-002'),
(4, 'tarde', '01310-200'),
(4, 'tarde', '01310-100'),

-- Sexta-feira (5)
(5, 'manha', '04038-001'),
(5, 'manha', '05407-002'),
(5, 'tarde', '01414-001'),
(5, 'tarde', '04094-050'),

-- Sábado (6)
(6, 'manha', '01327-001'),
(6, 'manha', '05508-010'),
(6, 'tarde', '04567-001'),
(6, 'tarde', '01452-000');
