-- -----------------------------------------------------
-- Schema oficina
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `oficina` DEFAULT CHARACTER SET utf8 ;
USE `oficina` ;

-- -----------------------------------------------------
-- Table `oficina`.`Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Serviço` (
  `idServiço` INT NOT NULL,
  `Descrição` VARCHAR(45) NULL,
  `Valor mão de obra` FLOAT NULL,
  PRIMARY KEY (`idServiço`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Pessoa` (
  `idPessoa` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `CPF` CHAR(11) NULL,
  `Endereço` VARCHAR(45) NULL,
  `Email` VARCHAR(45) NULL,
  `Telefone` VARCHAR(20) NULL,
  PRIMARY KEY (`idPessoa`),
  UNIQUE INDEX `Identificação_UNIQUE` (`CPF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Cliente` (
  `idCliente` INT NOT NULL,
  `Data Cadastro` DATE NULL,
  `Pessoa_idPessoa` INT NOT NULL,
  PRIMARY KEY (`idCliente`),
  INDEX `fk_Cliente_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `oficina`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Veículo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Veículo` (
  `idVeiculo` INT NOT NULL,
  `Placa` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Modelo` VARCHAR(45) NULL,
  `Ano` VARCHAR(45) NULL,
  `Cor` VARCHAR(45) NULL,
  `Cliente_idCliente` INT NOT NULL,
  PRIMARY KEY (`idVeiculo`),
  INDEX `fk_Veículo_Cliente_idx` (`Cliente_idCliente` ASC) VISIBLE,
  UNIQUE INDEX `Placa_UNIQUE` (`Placa` ASC) VISIBLE,
  CONSTRAINT `fk_Veículo_Cliente`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES `oficina`.`Cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Equipe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Equipe` (
  `idEquipe` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Turno` VARCHAR(45) NULL,
  PRIMARY KEY (`idEquipe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Ordem de Serviço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Ordem de Serviço` (
  `id_os` INT NOT NULL,
  `Número` INT NULL,
  `Data de emissão` DATE NULL,
  `Valor Total` FLOAT NULL,
  `Status` VARCHAR(45) NULL,
  `Autorização Cliente` TINYINT NULL,
  `Tipo` ENUM('Revisão', 'Conserto') NULL,
  `Data de entrega` DATE NULL,
  `Veículo_idVeiculo` INT NOT NULL,
  `Equipe_idEquipe` INT NOT NULL,
  PRIMARY KEY (`id_os`),
  INDEX `fk_Ordem de Serviço_Veículo1_idx` (`Veículo_idVeiculo` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  UNIQUE INDEX `Número_UNIQUE` (`Número` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_Veículo1`
    FOREIGN KEY (`Veículo_idVeiculo`)
    REFERENCES `oficina`.`Veículo` (`idVeiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Peças`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peças` (
  `idPeças` INT NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Marca` VARCHAR(45) NULL,
  `Valor Unitário` FLOAT NULL,
  `Quantidade estoque` INT NULL,
  PRIMARY KEY (`idPeças`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Mecânico`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Mecânico` (
  `idMecanico` INT NOT NULL,
  `Código` VARCHAR(45) NULL,
  `Especialidade` VARCHAR(45) NULL,
  `Equipe_idEquipe` INT NOT NULL,
  `Pessoa_idPessoa` INT NOT NULL,
  PRIMARY KEY (`idMecanico`),
  INDEX `fk_Mecânico_Equipe1_idx` (`Equipe_idEquipe` ASC) VISIBLE,
  INDEX `fk_Mecânico_Pessoa1_idx` (`Pessoa_idPessoa` ASC) VISIBLE,
  UNIQUE INDEX `Código_UNIQUE` (`Código` ASC) VISIBLE,
  CONSTRAINT `fk_Mecânico_Equipe1`
    FOREIGN KEY (`Equipe_idEquipe`)
    REFERENCES `oficina`.`Equipe` (`idEquipe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mecânico_Pessoa1`
    FOREIGN KEY (`Pessoa_idPessoa`)
    REFERENCES `oficina`.`Pessoa` (`idPessoa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Serviços na OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Serviços na OS` (
  `Serviço_idServiço` INT NOT NULL,
  `Ordem de Serviço_id_os` INT NOT NULL,
  `Observações` VARCHAR(45) NULL,
  PRIMARY KEY (`Serviço_idServiço`, `Ordem de Serviço_id_os`),
  INDEX `fk_Ordem de Serviço_has_Serviço_Serviço1_idx` (`Serviço_idServiço` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_has_Serviço_Ordem de Serviço1_idx` (`Ordem de Serviço_id_os` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_has_Serviço_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Serviço_id_os`)
    REFERENCES `oficina`.`Ordem de Serviço` (`Número`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_has_Serviço_Serviço1`
    FOREIGN KEY (`Serviço_idServiço`)
    REFERENCES `oficina`.`Serviço` (`idServiço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `oficina`.`Peças na OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `oficina`.`Peças na OS` (
  `Peças_idPeças` INT NOT NULL,
  `Ordem de Serviço_id_os` INT NOT NULL,
  `Quantidade` INT NULL,
  PRIMARY KEY (`Peças_idPeças`, `Ordem de Serviço_id_os`),
  INDEX `fk_Ordem de Serviço_has_Peças_Peças1_idx` (`Peças_idPeças` ASC) VISIBLE,
  INDEX `fk_Ordem de Serviço_has_Peças_Ordem de Serviço1_idx` (`Ordem de Serviço_id_os` ASC) VISIBLE,
  CONSTRAINT `fk_Ordem de Serviço_has_Peças_Ordem de Serviço1`
    FOREIGN KEY (`Ordem de Serviço_id_os`)
    REFERENCES `oficina`.`Ordem de Serviço` (`Número`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ordem de Serviço_has_Peças_Peças1`
    FOREIGN KEY (`Peças_idPeças`)
    REFERENCES `oficina`.`Peças` (`idPeças`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

----------------------------------------------------------------
-- Input
----------------------------------------------------------------

INSERT INTO `oficina`.`Serviço` (`idServiço`, `Descrição`, `Valor mão de obra`) VALUES
(1, 'Troca de óleo', 80.00),
(2, 'Alinhamento e balanceamento', 120.00),
(3, 'Troca de pastilhas de freio', 150.00),
(4, 'Reparo no motor', 300.00),
(5, 'Troca de bateria', 50.00);

INSERT INTO `oficina`.`Pessoa` (`idPessoa`, `Nome`, `CPF`, `Endereço`, `Email`, `Telefone`) VALUES
(1, 'João Silva', '12345678901', 'Rua A, 123', 'joao@email.com', '(11) 9999-1111'),
(2, 'Maria Santos', '23456789012', 'Av B, 456', 'maria@email.com', '(11) 9999-2222'),
(3, 'Carlos Oliveira', '34567890123', 'Rua C, 789', 'carlos@email.com', '(11) 9999-3333'),
(4, 'Ana Pereira', '45678901234', 'Av D, 101', 'ana@email.com', '(11) 9999-4444'),
(5, 'Pedro Souza', '56789012345', 'Rua E, 202', 'pedro@email.com', '(11) 9999-5555'),
(6, 'Mecânico José', '67890123456', 'Rua F, 303', 'jose@email.com', '(11) 9999-6666'),
(7, 'Mecânico Antônio', '78901234567', 'Av G, 404', 'antonio@email.com', '(11) 9999-7777'),
(8, 'Mecânica Marta', '89012345678', 'Rua H, 505', 'marta@email.com', '(11) 9999-8888'),
(9, 'Mecânico Ricardo', '90123456789', 'Av I, 606', 'ricardo@email.com', '(11) 9999-9999'),
(10, 'Mecânico Luiz', '01234567890', 'Rua J, 707', 'luiz@email.com', '(11) 9999-0000');

INSERT INTO `oficina`.`Cliente` (`idCliente`, `Data Cadastro`, `Pessoa_idPessoa`) VALUES
(1, '2023-01-15', 1),
(2, '2023-02-20', 2),
(3, '2023-03-10', 3),
(4, '2023-04-05', 4),
(5, '2023-05-12', 5);

INSERT INTO `oficina`.`Veículo` (`idVeiculo`, `Placa`, `Marca`, `Modelo`, `Ano`, `Cor`, `Cliente_idCliente`) VALUES
(1, 'ABC1D23', 'Fiat', 'Uno', '2015', 'Vermelho', 1),
(2, 'DEF4G56', 'Volkswagen', 'Gol', '2018', 'Prata', 2),
(3, 'GHI7J89', 'Chevrolet', 'Onix', '2020', 'Preto', 3),
(4, 'JKL0M12', 'Ford', 'Ka', '2019', 'Branco', 4),
(5, 'MNO3P45', 'Hyundai', 'HB20', '2021', 'Azul', 5);

INSERT INTO `oficina`.`Equipe` (`idEquipe`, `Nome`, `Turno`) VALUES
(1, 'Equipe Alfa', 'Manhã'),
(2, 'Equipe Beta', 'Tarde'),
(3, 'Equipe Gama', 'Noite'),
(4, 'Equipe Delta', 'Manhã'),
(5, 'Equipe Ômega', 'Tarde');

INSERT INTO `oficina`.`Ordem de Serviço` (`id_os`, `Número`, `Data de emissão`, `Valor Total`, `Status`, `Autorização Cliente`, `Tipo`, `Data de entrega`, `Veículo_idVeiculo`, `Equipe_idEquipe`) VALUES
(1, 1001, '2023-06-01', 250.00, 'Concluído', 1, 'Conserto', '2023-06-03', 1, 1),
(2, 1002, '2023-06-05', 180.00, 'Em andamento', 1, 'Revisão', NULL, 2, 2),
(3, 1003, '2023-06-10', 420.00, 'Aguardando peças', 1, 'Conserto', NULL, 3, 3),
(4, 1004, '2023-06-15', 150.00, 'Concluído', 1, 'Revisão', '2023-06-16', 4, 4),
(5, 1005, '2023-06-20', 300.00, 'Em andamento', 1, 'Conserto', NULL, 5, 5);

INSERT INTO `oficina`.`Peças` (`idPeças`, `Nome`, `Marca`, `Valor Unitário`, `Quantidade estoque`) VALUES
(1, 'Filtro de óleo', 'Bosch', 25.00, 50),
(2, 'Pastilha de freio', 'Ferodo', 80.00, 30),
(3, 'Bateria 60Ah', 'Moura', 350.00, 15),
(4, 'Vela de ignição', 'NGK', 45.00, 40),
(5, 'Correia dentada', 'Gates', 120.00, 20);

INSERT INTO `oficina`.`Mecânico` (`idMecanico`, `Código`, `Especialidade`, `Equipe_idEquipe`, `Pessoa_idPessoa`) VALUES
(1, 'MEC001', 'Motor', 1, 6),
(2, 'MEC002', 'Freios', 2, 7),
(3, 'MEC003', 'Elétrica', 3, 8),
(4, 'MEC004', 'Suspensão', 4, 9),
(5, 'MEC005', 'Transmissão', 5, 10);

INSERT INTO `oficina`.`Serviços na OS` (`Serviço_idServiço`, `Ordem de Serviço_id_os`, `Observações`) VALUES
(1, 1001, 'Troca de óleo sintético'),
(2, 1002, 'Alinhamento completo'),
(3, 1003, 'Troca das 4 pastilhas'),
(4, 1004, 'Revisão básica'),
(5, 1005, 'Reparo no cabeçote');

INSERT INTO `oficina`.`Peças na OS` (`Peças_idPeças`, `Ordem de Serviço_id_os`, `Quantidade`) VALUES
(1, 1001, 1),
(2, 1003, 4),
(3, 1005, 1),
(4, 1004, 4),
(5, 1005, 1);

----------------------------------------------------------------
-- Queries
----------------------------------------------------------------

-- Listar todos os clientes
SELECT * FROM Cliente;

-- Listar todos os veículos
SELECT Placa, Marca, Modelo, Ano FROM Veículo;

-- Listar todos os serviços disponíveis
SELECT idServiço, Descrição, `Valor mão de obra` FROM Serviço;

----------------------------------------------------------------
-- Veículos da marca Ford
SELECT * FROM Veículo WHERE Marca = 'Ford';

-- Serviços com valor de mão de obra acima de R$ 100
SELECT * FROM Serviço WHERE `Valor mão de obra` > 100;

-- Ordens de serviço do tipo 'Conserto'
SELECT * FROM `Ordem de Serviço` WHERE Tipo = 'Conserto';

-- Peças com estoque menor que 25 unidades
SELECT * FROM Peças WHERE `Quantidade estoque` < 25;

----------------------------------------------------------------
-- Valor total estimado de peças em estoque
SELECT 
    Nome, 
    `Valor Unitário`, 
    `Quantidade estoque`, 
    (`Valor Unitário` * `Quantidade estoque`) AS `Valor Total em Estoque`
FROM Peças;

-- Tempo de cadastro dos clientes em dias
SELECT 
    p.Nome, 
    c.`Data Cadastro`, 
    DATEDIFF(CURRENT_DATE(), c.`Data Cadastro`) AS `Dias desde o cadastro`
FROM Cliente c
JOIN Pessoa p ON c.Pessoa_idPessoa = p.idPessoa;

-- Valor médio de mão de obra dos serviços
SELECT AVG(`Valor mão de obra`) AS `Média de valor de mão de obra` FROM Serviço;

----------------------------------------------------------------
-- Serviços ordenados pelo valor (maior para menor)
SELECT * FROM Serviço ORDER BY `Valor mão de obra` DESC;

-- Veículos ordenados por ano (mais novos primeiro)
SELECT * FROM Veículo ORDER BY Ano DESC;

-- Peças ordenadas por valor unitário e quantidade em estoque
SELECT * FROM Peças ORDER BY `Valor Unitário` DESC, `Quantidade estoque` ASC;

-- Ordens de serviço mais recentes primeiro
SELECT * FROM `Ordem de Serviço` ORDER BY `Data de emissão` DESC;

----------------------------------------------------------------
-- Marcas de veículo com mais de 1 veículo cadastrado
SELECT Marca, COUNT(*) AS Quantidade 
FROM Veículo 
GROUP BY Marca 
HAVING COUNT(*) > 1;

-- Serviços com valor médio de mão de obra acima de R$ 100
SELECT AVG(`Valor mão de obra`) AS MediaValor 
FROM Serviço 
GROUP BY `Valor mão de obra` 
HAVING AVG(`Valor mão de obra`) > 100;

-- Peças com valor total em estoque superior a R$ 1000
SELECT 
    Nome, 
    SUM(`Valor Unitário` * `Quantidade estoque`) AS ValorTotalEstoque
FROM Peças
GROUP BY Nome
HAVING ValorTotalEstoque > 1000;
----------------------------------------------------------------
-- Listar ordens de serviço com detalhes do cliente e veículo
SELECT 
    os.Número AS OS,
    os.`Data de emissão`,
    os.Status,
    p.Nome AS Cliente,
    v.Placa,
    v.Marca,
    v.Modelo
FROM `Ordem de Serviço` os
JOIN Veículo v ON os.Veículo_idVeiculo = v.idVeiculo
JOIN Cliente c ON v.Cliente_idCliente = c.idCliente
JOIN Pessoa p ON c.Pessoa_idPessoa = p.idPessoa;

-- Detalhes completos de uma ordem de serviço (serviços e peças)
SELECT 
    os.Número AS OS,
    s.Descrição AS Serviço,
    s.`Valor mão de obra`,
    p.Nome AS Peça,
    pos.Quantidade,
    p.`Valor Unitário`,
    (p.`Valor Unitário` * pos.Quantidade) AS `Total Peças`
FROM `Ordem de Serviço` os
JOIN `Serviços na OS` sos ON os.Número = sos.`Ordem de Serviço_id_os`
JOIN Serviço s ON sos.`Serviço_idServiço` = s.idServiço
LEFT JOIN `Peças na OS` pos ON os.Número = pos.`Ordem de Serviço_id_os`
LEFT JOIN Peças p ON pos.`Peças_idPeças` = p.idPeças
WHERE os.Número = 1003;

-- Mecânicos e suas equipes com informações pessoais
SELECT 
    m.Código,
    p.Nome,
    p.Telefone,
    m.Especialidade,
    e.Nome AS Equipe,
    e.Turno
FROM Mecânico m
JOIN Pessoa p ON m.Pessoa_idPessoa = p.idPessoa
JOIN Equipe e ON m.Equipe_idEquipe = e.idEquipe
ORDER BY e.Nome, p.Nome;

-- Relatório financeiro: valor total por ordem de serviço
SELECT 
    os.Número AS OS,
    os.`Data de emissão`,
    SUM(s.`Valor mão de obra`) AS `Total Mão de Obra`,
    SUM(p.`Valor Unitário` * pos.Quantidade) AS `Total Peças`,
    (SUM(s.`Valor mão de obra`) + IFNULL(SUM(p.`Valor Unitário` * pos.Quantidade), 0)) AS `Valor Total`
FROM `Ordem de Serviço` os
JOIN `Serviços na OS` sos ON os.Número = sos.`Ordem de Serviço_id_os`
JOIN Serviço s ON sos.`Serviço_idServiço` = s.idServiço
LEFT JOIN `Peças na OS` pos ON os.Número = pos.`Ordem de Serviço_id_os`
LEFT JOIN Peças p ON pos.`Peças_idPeças` = p.idPeças
GROUP BY os.Número, os.`Data de emissão`
ORDER BY os.`Data de emissão` DESC;