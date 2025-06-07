-- Criação das tabelas do banco de dados Eco
-- Script 1: Criação das tabelas principais

-- Tabela de usuários
CREATE TABLE IF NOT EXISTS usuario (
    cpf VARCHAR(14) PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    nickname VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de funcionários
CREATE TABLE IF NOT EXISTS funcionario (
    codigo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(15) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    data_contratacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de endereços
CREATE TABLE IF NOT EXISTS endereco (
    cep VARCHAR(9) PRIMARY KEY,
    estado VARCHAR(2) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    logradouro VARCHAR(200) NOT NULL
);

-- Tabela de jogos
CREATE TABLE IF NOT EXISTS jogos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) UNIQUE NOT NULL,
    genero VARCHAR(50) NOT NULL,
    descricao TEXT,
    data_lancamento DATE,
    desenvolvedor VARCHAR(100),
    link_jogo VARCHAR(500),
    ativo BOOLEAN DEFAULT TRUE
);

-- Tabela de denúncias
CREATE TABLE IF NOT EXISTS denuncia (
    id SERIAL PRIMARY KEY,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT NOT NULL,
    datas TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_cpf VARCHAR(14) NOT NULL,
    endereco_cep VARCHAR(9) NOT NULL,
    status VARCHAR(20) DEFAULT 'pendente',
    anonima BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (usuario_cpf) REFERENCES usuario(cpf) ON DELETE CASCADE,
    FOREIGN KEY (endereco_cep) REFERENCES endereco(cep) ON DELETE RESTRICT
);

-- Tabela de atendimentos
CREATE TABLE IF NOT EXISTS atendimento (
    protocolo SERIAL PRIMARY KEY,
    data_atendimento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(20) DEFAULT 'pendente',
    funcionario_codigo INTEGER NOT NULL,
    denuncia_id INTEGER NOT NULL,
    FOREIGN KEY (funcionario_codigo) REFERENCES funcionario(codigo) ON DELETE RESTRICT,
    FOREIGN KEY (denuncia_id) REFERENCES denuncia(id) ON DELETE CASCADE
);

-- Tabela de respostas
CREATE TABLE IF NOT EXISTS resposta (
    id SERIAL PRIMARY KEY,
    mensagem TEXT NOT NULL,
    data_resposta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    atendimento_protocolo INTEGER NOT NULL,
    FOREIGN KEY (atendimento_protocolo) REFERENCES atendimento(protocolo) ON DELETE CASCADE
);

-- Tabela de avaliações
CREATE TABLE IF NOT EXISTS avaliacoes (
    id SERIAL PRIMARY KEY,
    usuario_cpf VARCHAR(14) NOT NULL,
    jogos_id INTEGER NOT NULL,
    avaliacao INTEGER CHECK (avaliacao >= 1 AND avaliacao <= 5),
    comentario TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_cpf) REFERENCES usuario(cpf) ON DELETE CASCADE,
    FOREIGN KEY (jogos_id) REFERENCES jogos(id) ON DELETE CASCADE,
    UNIQUE(usuario_cpf, jogos_id) -- Um usuário só pode avaliar um jogo uma vez
);

-- Tabela de horários de coleta
CREATE TABLE IF NOT EXISTS horarios_coleta (
    id SERIAL PRIMARY KEY,
    dia_semana INTEGER CHECK (dia_semana >= 0 AND dia_semana <= 6), -- 0=Domingo, 6=Sábado
    turno VARCHAR(10) CHECK (turno IN ('manha', 'tarde', 'noite')),
    endereco_cep VARCHAR(9) NOT NULL,
    FOREIGN KEY (endereco_cep) REFERENCES endereco(cep) ON DELETE CASCADE
);

-- Índices para melhorar performance
CREATE INDEX IF NOT EXISTS idx_denuncia_usuario ON denuncia(usuario_cpf);
CREATE INDEX IF NOT EXISTS idx_denuncia_endereco ON denuncia(endereco_cep);
CREATE INDEX IF NOT EXISTS idx_denuncia_status ON denuncia(status);
CREATE INDEX IF NOT EXISTS idx_atendimento_funcionario ON atendimento(funcionario_codigo);
CREATE INDEX IF NOT EXISTS idx_atendimento_denuncia ON atendimento(denuncia_id);
CREATE INDEX IF NOT EXISTS idx_avaliacoes_usuario ON avaliacoes(usuario_cpf);
CREATE INDEX IF NOT EXISTS idx_avaliacoes_jogo ON avaliacoes(jogos_id);
