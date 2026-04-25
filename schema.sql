-- ============================================================
-- Sistema Hospitalar com Foco em Segurança de Dados
-- Projeto: db-security-hospital
-- Autor: victor-cyber
-- Banco: PostgreSQL 18
-- ============================================================

-- Para recriar o banco do zero:
-- 1. Crie o banco: CREATE DATABASE hospital_security;
-- 2. Conecte ao banco e execute este arquivo

-- ============================================================
-- TABELAS BASE (sem dependências externas)
-- ============================================================

CREATE TABLE paciente (
    id_paciente     SERIAL          PRIMARY KEY,
    nome            VARCHAR(100)    NOT NULL,
    cpf             CHAR(11)        UNIQUE NOT NULL,
    data_nascimento DATE            NOT NULL,
    sexo            CHAR(1)         NOT NULL,
    telefone        VARCHAR(20),
    endereco        VARCHAR,
    email           VARCHAR
);

CREATE TABLE medico (
    id_medico       SERIAL          PRIMARY KEY,
    crm             CHAR(9)         UNIQUE NOT NULL,
    nome            VARCHAR         NOT NULL,
    telefone        VARCHAR(20),
    especialidade   VARCHAR         NOT NULL
);

CREATE TABLE medicacao (
    id_medicacao    SERIAL          PRIMARY KEY,
    nome            VARCHAR         NOT NULL,
    fabricante      VARCHAR,
    principio_ativo VARCHAR         NOT NULL
);

CREATE TABLE leito (
    id_leito        SERIAL          PRIMARY KEY,
    numero          VARCHAR         NOT NULL,
    status          VARCHAR         NOT NULL
);

-- ============================================================
-- TABELAS DEPENDENTES
-- ============================================================

CREATE TABLE consulta (
    id_consulta     SERIAL          PRIMARY KEY,
    id_paciente     INT             REFERENCES paciente(id_paciente),
    id_medico       INT             REFERENCES medico(id_medico),
    data_hora       TIMESTAMP       NOT NULL,
    status          VARCHAR         NOT NULL
);

CREATE TABLE prontuario (
    id_prontuario        SERIAL      PRIMARY KEY,
    id_paciente          INT         REFERENCES paciente(id_paciente),
    diagnostico          VARCHAR,
    alergias             VARCHAR,
    medicamento_continuo VARCHAR,
    ultima_atualizacao   TIMESTAMP   NOT NULL
);

CREATE TABLE prescricao (
    id_prescricao   SERIAL          PRIMARY KEY,
    id_consulta     INT             REFERENCES consulta(id_consulta),
    id_remedio      INT             REFERENCES medicacao(id_medicacao),
    duracao_dias    INT             NOT NULL,
    dosagem         VARCHAR(6)      NOT NULL,
    frequencia      VARCHAR         NOT NULL
);

CREATE TABLE exame (
    id_exame        SERIAL          PRIMARY KEY,
    id_consulta     INT             REFERENCES consulta(id_consulta),
    data_hora       TIMESTAMP       NOT NULL,
    tipo            VARCHAR
);

CREATE TABLE internacao (
    id_internacao   SERIAL          PRIMARY KEY,
    id_paciente     INT             REFERENCES paciente(id_paciente),
    id_leito        INT             REFERENCES leito(id_leito),
    motivo          VARCHAR         NOT NULL,
    data_hora       TIMESTAMP       NOT NULL,
    data_saida      DATE
);

-- ============================================================
-- TABELAS DE SEGURANÇA E AUDITORIA
-- Decisão de design: autenticação e logs desde o modelo conceitual
-- ============================================================

CREATE TABLE usuario_sistema (
    id_usuario      SERIAL          PRIMARY KEY,
    id_medico       INT             REFERENCES medico(id_medico),
    login           VARCHAR         NOT NULL UNIQUE,
    -- senha_hash: nunca armazenar senha em texto puro
    -- usar bcrypt ou argon2 na aplicação antes de inserir
    senha_hash      VARCHAR         NOT NULL,
    perfil          VARCHAR         NOT NULL,
    ultimo_acesso   TIMESTAMP
);

CREATE TABLE log_acesso (
    id_log          SERIAL          PRIMARY KEY,
    id_usuario      INT             REFERENCES usuario_sistema(id_usuario),
    -- registra QUEM fez, O QUÊ fez, QUANDO e DE ONDE
    operacao        VARCHAR         NOT NULL, -- SELECT, INSERT, UPDATE, DELETE
    tabela_acessada VARCHAR         NOT NULL,
    data_hora       TIMESTAMP       NOT NULL,
    ip_origem       VARCHAR         NOT NULL
);
