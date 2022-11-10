CREATE USER 'Danielmb'@'HOST' IDENTIFIED BY 'daniel2003';
GRANT Reload ON *.* TO 'Danielmb'@'HOST';
GRANT Process ON *.* TO 'Danielmb'@'HOST';
GRANT File ON *.* TO 'Danielmb'@'HOST';
GRANT Event ON *.* TO 'Danielmb'@'HOST';
GRANT Create user ON *.* TO 'Danielmb'@'HOST';
GRANT Create tablespace ON *.* TO 'Danielmb'@'HOST';
GRANT Alter ON *.* TO 'Danielmb'@'HOST';
GRANT Create ON *.* TO 'Danielmb'@'HOST';
GRANT Index ON *.* TO 'Danielmb'@'HOST';
GRANT Insert ON *.* TO 'Danielmb'@'HOST';
GRANT Update ON *.* TO 'Danielmb'@'HOST';

CREATE DATABASE `uvv` /*!40100 DEFAULT CHARACTER SET latin1 */;
GRANT ALL PRIVILEGES ON uvv.* TO 'Danielmb'@'HOST';
use uvv;


CREATE SCHEMA IF NOT EXISTS hr DEFAULT CHARACTER SET utf8 ;
USE `hr` ;

-- SQLINES DEMO *** ------------------------------------
-- SQLINES DEMO *** es`
-- SQLINES DEMO *** ------------------------------------
-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE IF NOT EXISTS hr.regioes (
  `id_regiao` INT NOT NULL AUTO_INCREMENT COMMENT 'primary key da tabela.',
  `nome` VARCHAR(25) NOT NULL COMMENT 'Nomes das regiões.',
  PRIMARY KEY (`id_regiao`),
  CONSTRAINT `nome_UNIQUE` UNIQUE (`nome` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS hr.paises (
  `id_paises` CHAR(2) NOT NULL COMMENT 'primary kei da tabela',
  `nome` VARCHAR(50) NOT NULL COMMENT 'Nome do país.',
  `id_regiao` INT NULL,
  PRIMARY KEY (`id_paises`),
  CONSTRAINT `nome_UNIQUE` UNIQUE (`nome` ASC) VISIBLE,
  INDEX fk_paises_regioes_idx (`id_regiao` ASC) VISIBLE,
  CONSTRAINT `fk_paises_regioes`
    FOREIGN KEY (`id_regiao`)
    REFERENCES hr.regioes (`id_regiao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS hr.localizacoes (
  `id_localizacao` INT NOT NULL COMMENT 'primary key da tabela.',
  `endereco` VARCHAR(50) NULL COMMENT 'Endereço de um escritório ou uma facilidade da empresa.',
  `cep` VARCHAR(12) NULL COMMENT 'CEP da localização de um escritório ou facilidade da empresa.',
  `uf` VARCHAR(25) NULL COMMENT 'Estado onde está localizado o escritório ou outra facilidade da empresa.',
  `id_paises` CHAR(2) NULL COMMENT 'Chave estrangeira para a tabela de países.',
  PRIMARY KEY (`id_localizacao`)
  CREATE INDEX `fk_localizacoes_paises1_idx` ON hr.localizacoes (`id_paises` ASC) VISIBLE,
  CONSTRAINT `fk_localizacoes_paises1`
    FOREIGN KEY (`id_paises`)
    REFERENCES hr.paises (`id_paises`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS hr.cargos (
  `id_cargo` VARCHAR(10) NOT NULL COMMENT 'primary key da tabela.',
  `cargo` VARCHAR(35) NOT NULL COMMENT 'Nome do cargo.',
  `salario_minimo` DECIMAL(8,2) NULL COMMENT 'Menor salário aceito para um cargo.',
  `salario_maximo` DECIMAL(8,2) NULL COMMENT 'Mair salário aceito para um cargo.',
  PRIMARY KEY (`id_cargo`),
  CONSTRAINT `cargo_UNIQUE` UNIQUE (`cargo` ASC) VISIBLE)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS hr.empregados (
  `id_empregado` INT NOT NULL AUTO_INCREMENT COMMENT 'primary key da tabela',
  `nome` VARCHAR(75) NOT NULL COMMENT 'Nome e sobrenome do empregado.',
  `email` VARCHAR(35) NOT NULL COMMENT 'parte inicial do email do empregado.',
  `telefone` VARCHAR(20) NULL COMMENT 'telefone do empregado( espaço para codigo do país e DDD)',
  `data_contratacao` DATE NOT NULL COMMENT 'data que o empregado iniciou no cargo atual.',
  `id_cargo` VARCHAR(10) NOT NULL COMMENT 'Chave estrangeira para a tabela cargos. Indica o cargo atual do empregado.',
  `salario` DECIMAL(8,2) NULL COMMENT 'Salario do empregado(mensal)',
  `comissao` DECIMAL(4,2) NULL COMMENT 'Porcentagem de comissão de um empregado. Apenas empregados no departamento de vendas sao elegíveis para comissões.',
  `id_departamento` INT NULL COMMENT 'Chave estrangeira para a tabela de departamentos. Indica o departamento atual de um empregado.',
  `id_supervisor` INT NULL COMMENT 'Chave esrangeira para a própria tabela empregados(auto-relacionamento). Indica o supervisor direto do empregado(pode corresponder ou não ao manager_id do departamento do empregado.',
  PRIMARY KEY (`id_empregado`),
  CONSTRAINT `email_UNIQUE` UNIQUE (`email` ASC) VISIBLE,
  INDEX fk_empregados_cargos1_idx (`id_cargo` ASC) VISIBLE,
  INDEX fk_empregados_departamentos1_idx (`id_departamento` ASC) VISIBLE,
  INDEX fk_empregados_empregados1_idx (`id_supervisor` ASC) VISIBLE,
  CONSTRAINT `fk_empregados_cargos1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES hr.cargos (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empregados_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES hr.departamentos (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_empregados_empregados1`
    FOREIGN KEY (`id_supervisor`)
    REFERENCES hr.empregados (`id_empregado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


CREATE TABLE IF NOT EXISTS hr.departamentos (
  `id_departamento` INT NOT NULL AUTO_INCREMENT COMMENT 'primary key da tabela.',
  `nome` VARCHAR(50) NULL COMMENT 'Nome do departamento da tabela.',
  `id_localizacao` INT NULL COMMENT 'Chave estrangeira para a tabela de empregados, representando qual empregado, se houver, é o gerente deste departamento.',
  `id_gerente` INT NULL COMMENT 'Chave estrangeira para a tabela localizações.',
  PRIMARY KEY (`id_departamento`),
  CONSTRAINT `nome_UNIQUE` UNIQUE (`nome` ASC) VISIBLE,
  INDEX fk_departamentos_localizacoes1_idx (`id_localizacao` ASC) VISIBLE,
  INDEX fk_departamentos_empregados1_idx (`id_gerente` ASC) VISIBLE,
  CONSTRAINT `fk_departamentos_localizacoes1`
    FOREIGN KEY (`id_localizacao`)
    REFERENCES hr.localizacoes (`id_localizacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_departamentos_empregados1`
    FOREIGN KEY (`id_gerente`)
    REFERENCES hr.empregados (`id_empregado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



CREATE TABLE IF NOT EXISTS hr.historico_cargos (
  `id_empregado` INT NOT NULL COMMENT 'Parte chave primária composta da tabela(empregado_id e data inicial).Também é uma chave estrangeira para a tabela empregados.',
  `data_inicial` DATE NOT NULL COMMENT 'Parte da chave primária composta da tabela(empregado_id e data_inicial). Indica a data inicial do empregado em um novo cargo. deve ser menor do que a data_final.',
  `data_final` DATE NOT NULL COMMENT 'Último dia de um empregado neste cargo. deve ser maior do que a data inical.',
  `id_cargo` VARCHAR(0) NOT NULL COMMENT 'Chave estrangeira para a tabela de cargos. Corresponde ao cargo em que o empregado estava trabalhando anteriormente.',
  `id_departamento` INT NULL COMMENT 'Chave estrangeira para a tabela departamentos. Corresponde ao departamento em que o empregado estava trabalhand oanteriormente'
  CREATE INDEX `fk_historico_cargos_empregados1_idx` ON hr.historico_cargos (`id_empregado` ASC) VISIBLE,
  PRIMARY KEY (`id_empregado`, `data_inicial`),
  INDEX fk_historico_cargos_cargos1_idx (`id_cargo` ASC) VISIBLE,
  INDEX fk_historico_cargos_departamentos1_idx (`id_departamento` ASC) VISIBLE,
  CONSTRAINT `fk_historico_cargos_empregados1`
    FOREIGN KEY (`id_empregado`)
    REFERENCES hr.empregados (`id_empregado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_cargos_cargos1`
    FOREIGN KEY (`id_cargo`)
    REFERENCES hr.cargos (`id_cargo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_historico_cargos_departamentos1`
    FOREIGN KEY (`id_departamento`)
    REFERENCES hr.departamentos (`id_departamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


