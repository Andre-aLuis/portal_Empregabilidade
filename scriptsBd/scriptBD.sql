CREATE DATABASE portal_empregabilidade;

USE portal_empregabilidade;

CREATE TABLE usuario (
    id int PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha VARCHAR(255) NOT NULL,
    tipo_usuario ENUM('candidato', 'recrutador') NOT NULL
);

CREATE TABLE candidato (
    id int PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    curriculo TEXT,
    habilidades TEXT,
    localizacao VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE empresa (
    id int PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    setor VARCHAR(100),
    descricao TEXT,
    politicas_diversidade TEXT
);

CREATE TABLE recrutador (
    id int PRIMARY KEY,
    id_usuario INT UNIQUE NOT NULL,
    id_empresa INT NOT NULL,
    cargo VARCHAR(100),
    FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE,
    FOREIGN KEY (id_empresa) REFERENCES empresa(id) ON DELETE CASCADE
);

CREATE TABLE vaga (
    id int PRIMARY KEY,
    id_empresa INT NOT NULL,
    titulo VARCHAR(150) NOT NULL,
    descricao TEXT,
    requisitos TEXT,
    tipo ENUM('presencial', 'remoto', 'híbrido') NOT NULL,
    data_postagem TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_empresa) REFERENCES empresa(id) ON DELETE CASCADE
);

CREATE TABLE aplicacao (
    id SERIAL PRIMARY KEY,
    id_vaga INT NOT NULL,
    id_candidato INT NOT NULL,
    status ENUM('pendente', 'aprovado', 'rejeitado') DEFAULT 'pendente',
    FOREIGN KEY (id_vaga) REFERENCES vaga(id) ON DELETE CASCADE,
    FOREIGN KEY (id_candidato) REFERENCES candidato(id) ON DELETE CASCADE
);

CREATE TABLE feedback (
    id SERIAL PRIMARY KEY,
    id_candidato INT NOT NULL,
    id_recrutador INT NOT NULL,
    comentario TEXT,
    nota INT CHECK (nota BETWEEN 1 AND 5),
    FOREIGN KEY (id_candidato) REFERENCES candidato(id) ON DELETE CASCADE,
    FOREIGN KEY (id_recrutador) REFERENCES recrutador(id) ON DELETE CASCADE
);