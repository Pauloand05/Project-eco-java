-- Script 8: Inserção de respostas aos atendimentos

INSERT INTO resposta (mensagem, atendimento_protocolo) VALUES
('Denúncia recebida. Estamos encaminhando para o departamento de limpeza urbana responsável pela região da Avenida Paulista.', 1),
('Equipe de limpeza foi enviada ao local. O lixo foi removido e a área foi higienizada. Problema resolvido.', 1),

('Denúncia de poluição sonora recebida. Estamos verificando a situação com a fiscalização municipal.', 2),
('Fiscalização foi ao local e constatou a irregularidade. Auto de infração foi aplicado ao estabelecimento.', 2),

('Denúncia sobre vazamento de óleo recebida. Equipe técnica será enviada para avaliação.', 4),
('Local foi vistoriado. Identificamos a fonte do vazamento e acionamos a empresa responsável pela limpeza.', 4),

('Denúncia sobre queima de lixo foi recebida. Fiscalização ambiental foi acionada.', 6),
('Fiscalização aplicou multa aos responsáveis e orientou sobre descarte correto. Situação resolvida.', 6),

('Denúncia sobre descarte de produtos químicos recebida. Caso encaminhado para órgão ambiental competente.', 7);
