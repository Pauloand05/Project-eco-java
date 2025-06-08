-- Script 12: Consultas de exemplo para testar o banco

-- 1. Listar todas as denúncias com informações completas
SELECT * FROM vw_denuncias_completas LIMIT 10;

-- 2. Estatísticas dos jogos mais bem avaliados
SELECT * FROM vw_estatisticas_jogos;

-- 3. Buscar denúncias pendentes
SELECT * FROM buscar_denuncias_por_status('pendente');

-- 4. Estatísticas gerais do sistema
SELECT * FROM estatisticas_gerais();

-- 5. Denúncias por região (cidade)
SELECT 
    e.cidade,
    e.estado,
    COUNT(d.id) as total_denuncias,
    COUNT(CASE WHEN d.status = 'pendente' THEN 1 END) as pendentes,
    COUNT(CASE WHEN d.status = 'resolvida' THEN 1 END) as resolvidas
FROM endereco e
LEFT JOIN denuncia d ON e.cep = d.endereco_cep
GROUP BY e.cidade, e.estado
ORDER BY total_denuncias DESC;

-- 6. Funcionários mais ativos
SELECT 
    f.nome,
    f.email,
    COUNT(a.protocolo) as total_atendimentos,
    COUNT(CASE WHEN a.status = 'concluido' THEN 1 END) as atendimentos_concluidos
FROM funcionario f
LEFT JOIN atendimento a ON f.codigo = a.funcionario_codigo
GROUP BY f.codigo, f.nome, f.email
ORDER BY total_atendimentos DESC;

-- 7. Jogos por gênero com média de avaliação
SELECT 
    genero,
    COUNT(*) as total_jogos,
    ROUND(AVG(media_avaliacao), 2) as media_genero
FROM vw_estatisticas_jogos
WHERE total_avaliacoes > 0
GROUP BY genero
ORDER BY media_genero DESC;

-- 8. Horários de coleta por dia da semana
SELECT 
    CASE dia_semana
        WHEN 0 THEN 'Domingo'
        WHEN 1 THEN 'Segunda-feira'
        WHEN 2 THEN 'Terça-feira'
        WHEN 3 THEN 'Quarta-feira'
        WHEN 4 THEN 'Quinta-feira'
        WHEN 5 THEN 'Sexta-feira'
        WHEN 6 THEN 'Sábado'
    END as dia,
    turno,
    COUNT(*) as total_coletas
FROM horarios_coleta
GROUP BY dia_semana, turno
ORDER BY dia_semana, turno;

-- 9. Usuários mais ativos (que mais fizeram denúncias)
SELECT 
    u.nome,
    u.nickname,
    COUNT(d.id) as total_denuncias,
    COUNT(CASE WHEN d.status = 'resolvida' THEN 1 END) as denuncias_resolvidas
FROM usuario u
LEFT JOIN denuncia d ON u.cpf = d.usuario_cpf
GROUP BY u.cpf, u.nome, u.nickname
HAVING COUNT(d.id) > 0
ORDER BY total_denuncias DESC;

-- 10. Tempo médio de resolução de denúncias
SELECT 
    AVG(
        EXTRACT(DAY FROM (
            SELECT MIN(r.data_resposta) 
            FROM resposta r 
            JOIN atendimento a ON r.atendimento_protocolo = a.protocolo 
            WHERE a.denuncia_id = d.id
        ) - d.datas)
    ) as tempo_medio_dias
FROM denuncia d
WHERE d.status = 'resolvida';
