-- Primeira tarefa: Criar Banco de dados 

-- Database: uvv 

-- DROP DATABASE IF EXISTS uvv;

CREATE DATABASE uvv
    WITH 
    OWNER = "DanielMeneguelli"
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;


-- Segunda tarefa: Criação de usuário

-- Role: "DanielMeneguelli"

-- DROP ROLE IF EXISTS "DanielMeneguelli";

CREATE ROLE "DanielMeneguelli" WITH
  LOGIN
  NOSUPERUSER
  INHERIT
  CREATEDB
  NOCREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:w/x5fQwE42JfvnjfLzfR3Q==$3APaXFU5wUL3/MP6lOiPsrdlROTYfKp+r1GukquNhYI=:cM8s/wg3DfUR2chvaJ1Iawdt0Ff2WJonScIRIu1XBMU=';

-- Terceira tarefa: Criação do esquema 

-- SCHEMA: hr

-- DROP SCHEMA IF EXISTS hr ;

CREATE SCHEMA IF NOT EXISTS hr
    AUTHORIZATION postgres;

-- Quarta tarefa: Ordem de Esquemas

SET SEARCH_PATH TO hr, "$user", public;


-- Quinta tarefa: Criação das tabelas

-- SQLINES DEMO *** rated by MySQL Workbench
-- SQLINES DEMO *** 55 2022
-- SQLINES DEMO ***    Version: 1.0
-- SQLINES DEMO *** orward Engineering

/* SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0; */
/* SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0; */
/* SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION'; */

-- SQLINES DEMO *** ------------------------------------
-- Schema hr
-- SQLINES DEMO *** ------------------------------------

-- SQLINES DEMO *** ------------------------------------
-- Schema hr
-- SQLINES DEMO *** ------------------------------------
CREATE SCHEMA IF NOT EXISTS hr DEFAULT CHARACTER SET utf8 ;
SET SCHEMA 'hr' ;

-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** es`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE hr.regioes_seq;

CREATE TABLE IF NOT EXISTS hr.regioes (
  id_regiao INT NOT NULL DEFAULT NEXTVAL ('hr.regioes_seq') ,
  nome VARCHAR(25) NOT NULL ,
  PRIMARY KEY (id_regiao),
  CONSTRAINT nome_UNIQUE UNIQUE (nome) VISIBLE)
ENGINE = InnoDB;


-- SQLINES DEMO *** ------------------------------------
-- Table `hr`.`paises`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.paises (
  id_paises CHAR(2) NOT NULL ,
  nome VARCHAR(50) NOT NULL ,
  id_regiao INT NULL,
  PRIMARY KEY (id_paises),
  CONSTRAINT nome_UNIQUE UNIQUE (nome) VISIBLE,
  INDEX fk_paises_regioes_idx (id_regiao ASC) VISIBLE,
  CONSTRAINT fk_paises_regioes
    FOREIGN KEY (id_regiao)
    REFERENCES hr.regioes (id_regiao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** izacoes`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.localizacoes (
  id_localizacao INT NOT NULL ,
  endereco VARCHAR(50) NULL ,
  cep VARCHAR(12) NULL ,
  uf VARCHAR(25) NULL ,
  id_paises CHAR(2) NULL ,
  PRIMARY KEY (id_localizacao)
  CREATE INDEX fk_localizacoes_paises1_idx ON hr.localizacoes (id_paises ASC) VISIBLE,
  CONSTRAINT fk_localizacoes_paises1
    FOREIGN KEY (id_paises)
    REFERENCES hr.paises (id_paises)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- SQLINES DEMO *** ------------------------------------
-- Table `hr`.`cargos`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.cargos (
  id_cargo VARCHAR(10) NOT NULL ,
  cargo VARCHAR(35) NOT NULL ,
  salario_minimo DECIMAL(8,2) NULL ,
  salario_maximo DECIMAL(8,2) NULL ,
  PRIMARY KEY (id_cargo),
  CONSTRAINT cargo_UNIQUE UNIQUE (cargo) VISIBLE)
ENGINE = InnoDB;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** gados`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE hr.empregados_seq;

CREATE TABLE IF NOT EXISTS hr.empregados (
  id_empregado INT NOT NULL DEFAULT NEXTVAL ('hr.empregados_seq') ,
  nome VARCHAR(75) NOT NULL ,
  email VARCHAR(35) NOT NULL ,
  telefone VARCHAR(20) NULL ,
  data_contratacao DATE NOT NULL ,
  id_cargo VARCHAR(10) NOT NULL ,
  salario DECIMAL(8,2) NULL ,
  comissao DECIMAL(4,2) NULL ,
  id_departamento INT NULL ,
  id_supervisor INT NULL ,
  PRIMARY KEY (id_empregado),
  CONSTRAINT email_UNIQUE UNIQUE (email) VISIBLE,
  INDEX fk_empregados_cargos1_idx (id_cargo ASC) VISIBLE,
  INDEX fk_empregados_departamentos1_idx (id_departamento ASC) VISIBLE,
  INDEX fk_empregados_empregados1_idx (id_supervisor ASC) VISIBLE,
  CONSTRAINT fk_empregados_cargos1
    FOREIGN KEY (id_cargo)
    REFERENCES hr.cargos (id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_empregados_departamentos1
    FOREIGN KEY (id_departamento)
    REFERENCES hr.departamentos (id_departamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_empregados_empregados1
    FOREIGN KEY (id_supervisor)
    REFERENCES hr.empregados (id_empregado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** tamentos`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE SEQUENCE hr.departamentos_seq;

CREATE TABLE IF NOT EXISTS hr.departamentos (
  id_departamento INT NOT NULL DEFAULT NEXTVAL ('hr.departamentos_seq') ,
  nome VARCHAR(50) NULL ,
  id_localizacao INT NULL ,
  id_gerente INT NULL ,
  PRIMARY KEY (id_departamento),
  CONSTRAINT nome_UNIQUE UNIQUE (nome) VISIBLE,
  INDEX fk_departamentos_localizacoes1_idx (id_localizacao ASC) VISIBLE,
  INDEX fk_departamentos_empregados1_idx (id_gerente ASC) VISIBLE,
  CONSTRAINT fk_departamentos_localizacoes1
    FOREIGN KEY (id_localizacao)
    REFERENCES hr.localizacoes (id_localizacao)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_departamentos_empregados1
    FOREIGN KEY (id_gerente)
    REFERENCES hr.empregados (id_empregado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** rico_cargos`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.historico_cargos (
  id_empregado INT NOT NULL ,
  data_inicial DATE NOT NULL ,
  data_final DATE NOT NULL ,
  id_cargo VARCHAR(0) NOT NULL ,
  id_departamento INT NULL 
  CREATE INDEX fk_historico_cargos_empregados1_idx ON hr.historico_cargos (id_empregado ASC) VISIBLE,
  PRIMARY KEY (id_empregado, data_inicial),
  INDEX fk_historico_cargos_cargos1_idx (id_cargo ASC) VISIBLE,
  INDEX fk_historico_cargos_departamentos1_idx (id_departamento ASC) VISIBLE,
  CONSTRAINT fk_historico_cargos_empregados1
    FOREIGN KEY (id_empregado)
    REFERENCES hr.empregados (id_empregado)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_historico_cargos_cargos1
    FOREIGN KEY (id_cargo)
    REFERENCES hr.cargos (id_cargo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_historico_cargos_departamentos1
    FOREIGN KEY (id_departamento)
    REFERENCES hr.departamentos (id_departamento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


/* SET SQL_MODE=@OLD_SQL_MODE; */
/* SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS; */
/* SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS; */
