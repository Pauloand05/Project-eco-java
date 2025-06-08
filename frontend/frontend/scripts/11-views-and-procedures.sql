-- Script 11: Views e procedures úteis

-- View para relatório de denúncias com informações completas
CREATE OR REPLACE VIEW vw_denuncias_completas AS
SELECT 
    d.id,
    d.titulo,
    d.descricao,
    d.datas,
    d.status,
    d.anonima,
    CASE 
        WHEN d.anonima = TRUE THEN 'Anônimo'
        ELSE u.nome
    END as nome_usuario,
    CASE 
        WHEN d.anonima = TRUE THEN 'Anônimo'
        ELSE u.nickname
    END as nickname_usuario,
    e.logradouro,
    e.bairro,
    e.cidade,
    e.estado,
    e.cep
FROM denuncia d
JOIN usuario u ON d.usuario_cpf = u.cpf
JOIN endereco e ON d.endereco_cep = e.cep
ORDER BY d.datas DESC;

-- View para estatísticas de jogos
CREATE OR REPLACE VIEW vw_estatisticas_jogos AS
SELECT 
    j.id,
    j.nome,
    j.genero,
    COUNT(a.id) as total_avaliacoes,
    ROUND(AVG(a.avaliacao), 2) as media_avaliacao,
    MAX(a.avaliacao) as melhor_avaliacao,
    MIN(a.avaliacao) as pior_avaliacao
FROM jogos j
LEFT JOIN avaliacoes a ON j.id = a.jogos_id
GROUP BY j.id, j.nome, j.genero
ORDER BY media_avaliacao DESC NULLS LAST;

-- View para atendimentos com detalhes
CREATE OR REPLACE VIEW vw_atendimentos_detalhados AS
SELECT 
    a.protocolo,
    a.data_atendimento,
    a.status as status_atendimento,
    f.nome as nome_funcionario,
    f.email as email_funcionario,
    d.id as denuncia_id,
    d.titulo as titulo_denuncia,
    d.status as status_denuncia,
    CASE 
        WHEN d.anonima = TRUE THEN 'Anônimo'
        ELSE u.nome
    END as nome_denunciante,
    COUNT(r.id) as total_respostas
FROM atendimento a
JOIN funcionario f ON a.funcionario_codigo = f.codigo
JOIN denuncia d ON a.denuncia_id = d.id
JOIN usuario u ON d.usuario_cpf = u.cpf
LEFT JOIN resposta r ON a.protocolo = r.atendimento_protocolo
GROUP BY a.protocolo, a.data_atendimento, a.status, f.nome, f.email, 
         d.id, d.titulo, d.status, d.anonima, u.nome
ORDER BY a.data_atendimento DESC;

-- Função para buscar denúncias por status
CREATE OR REPLACE FUNCTION buscar_denuncias_por_status(status_param VARCHAR(20))
RETURNS TABLE (
    id INTEGER,
    titulo VARCHAR(200),
    descricao TEXT,
    data_criacao TIMESTAMP,
    nome_usuario TEXT,
    endereco_completo TEXT
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        d.id,
        d.titulo,
        d.descricao,
        d.datas,
        CASE 
            WHEN d.anonima = TRUE THEN 'Anônimo'::TEXT
            ELSE u.nome::TEXT
        END,
        CONCAT(e.logradouro, ', ', e.bairro, ', ', e.cidade, ' - ', e.estado)::TEXT
    FROM denuncia d
    JOIN usuario u ON d.usuario_cpf = u.cpf
    JOIN endereco e ON d.endereco_cep = e.cep
    WHERE d.status = status_param
    ORDER BY d.datas DESC;
END;
$$ LANGUAGE plpgsql;

-- Função para calcular estatísticas gerais
CREATE OR REPLACE FUNCTION estatisticas_gerais()
RETURNS TABLE (
    total_usuarios BIGINT,
    total_denuncias BIGINT,
    denuncias_pendentes BIGINT,
    denuncias_resolvidas BIGINT,
    total_jogos BIGINT,
    total_avaliacoes BIGINT,
    media_geral_avaliacoes NUMERIC
) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        (SELECT COUNT(*) FROM usuario WHERE ativo = TRUE),
        (SELECT COUNT(*) FROM denuncia),
        (SELECT COUNT(*) FROM denuncia WHERE status = 'pendente'),
        (SELECT COUNT(*) FROM denuncia WHERE status = 'resolvida'),
        (SELECT COUNT(*) FROM jogos WHERE ativo = TRUE),
        (SELECT COUNT(*) FROM avaliacoes),
        (SELECT ROUND(AVG(avaliacao), 2) FROM avaliacoes);
END;
$$ LANGUAGE plpgsql;
