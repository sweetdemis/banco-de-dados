DROP TABLE IF EXISTS funcionario
DROP TABLE IF EXISTS cliente
DROP TABLE IF EXISTS carro
DROP TABLE IF EXISTS venda
DROP TABLE IF EXISTS proposta

CREATE TABLE funcionario (
    codFuncionario int NOT NULL,
    nome varchar(100) NOT NULL,
    cpf varchar(11) UNIQUE,
    dataNascimento date,
    login varchar(20) NOT NULL,
    senha varchar(20) NOT NULL,
    salario float NOT NULL,
    cargaHoraria int,
    CONSTRAINT "funcionarioPK" PRIMARY KEY (codfuncionario));
    
CREATE TABLE cliente (
    codCliente int NOT NULL,
    nome varchar(100) NOT NULL,
    cpf varchar(11) UNIQUE,
    dataNascimento date,
    telefone int,
    endereco varchar(50),
    email varchar,
    CONSTRAINT "clientePK" PRIMARY KEY (codcliente));
    
CREATE TABLE carro (
    codCarro int NOT NULL,
    marca varchar,
    modelo varchar,
    anoFabricacao int,
    valor float NOT NULL,
    CONSTRAINT "carroPK" PRIMARY KEY (codcarro));  

CREATE TABLE venda (
	codVenda serial,
	codCarro int,
	anoFabricacao int,
	valorVenda float NOT NULL,
	codFuncionario int NOT NULL,
	codCliente int NOT NULL,
	CONSTRAINT "vendaPK" PRIMARY KEY (codvenda),
	CONSTRAINT "CarroVendaFK" FOREIGN KEY(codcarro) REFERENCES carro(codcarro),
	CONSTRAINT "FuncionarioVendaFK" FOREIGN KEY(codfuncionario) REFERENCES funcionario(codfuncionario),
	CONSTRAINT "ClienteVendaFK" FOREIGN KEY(codcliente) REFERENCES cliente(codcliente))

CREATE TABLE proposta (
	codProposta int,
	codCarro int,
	codFuncionario int,
	codCliente int,
	valorInicial int,
	valorFinal int, 
	dataVenda date, 
	CONSTRAINT "PropostaPK" PRIMARY KEY (codproposta),
	CONSTRAINT "CarroPropostaFK" FOREIGN KEY(codcarro) REFERENCES carro(codcarro),
	CONSTRAINT "FuncionarioPropostaFK" FOREIGN KEY(codfuncionario) REFERENCES funcionario(codfuncionario),
	CONSTRAINT "ClientePropostaFK" FOREIGN KEY(codcliente) REFERENCES cliente(codcliente))
	
INSERT INTO funcionario (codfuncionario, nome, cpf, datanascimento, login, senha, salario, cargahoraria) VALUES 
(001, 'Louis Tomlinson', 28214672911, to_date('24/12/1991','DD/MM/YYYY'), 'aluisio', 'walls28', 56578, 30),
(002, 'Harry Styles', 85381630923, to_date('01/02/1993','DD/MM/YYYY'), 'harold', 'medicine', 56300, 30),
(003, 'Niall Horan', 27400912335, to_date('13/09/1993','DD/MM/YYYY'), 'nai', 'azul', 55400, 30),
(004, 'Zayn Malik', 46297439222, to_date('12/01/1993','DD/MM/YYYY'), 'zain', 'goodyears', 56120, 32),
(005, 'Liam Payne', 16382929963, to_date('29/08/1992','DD/MM/YYYY'), 'payno', 'rudehours13', 54700, 29),
(006, 'Taylor Swift', 13131678771, to_date('13/12/1989','DD/MM/YYYY'), 'taylor', 'august13', 62800, 25),
(007, 'James Bond', 18945678203, to_date('16/05/1953', 'DD/MM/YYYY'), 'bondbond', 'eujamesbond7', 40000, 30),
(008, 'Anne Hathaway', 94587326045, to_date('12/11/1982', 'DD/MM/YYYY'), 'anneh', 'getreal02', 55000, 28);

INSERT INTO cliente (codcliente, nome, cpf, datanascimento, telefone, endereco, email) VALUES
(101, 'Vânia Tanzânia', 23458510283, to_date('22/12/1987','DD/MM/YYYY'), 977884345, 'rua greenwood, 3454', 'vaniat@gmail.com'),
(102, 'Romeu Jubileu', 78430935677, to_date('30/01/1990','DD/MM/YYYY'), 981234455, 'irere, 678', 'jubijubi@gmail.com'),
(103, 'Julieta Maria', 36284629364, to_date('04/06/2000','DD/MM/YYYY'), 923236490, 'nothing hill, 1309', 'jueta@gmail.com'),
(104, 'Virgulino Vastor', 45279173618, to_date('09/07/1973','DD/MM/YYYY'), 987864623, 'carpasinha, 4', 'virgulinho@gmail.com'),
(105, 'Joui Jouk', 32845193716, to_date('04/04/1994','DD/MM/YYYY'), 980456704, 'sao paolo, 4444', 'jouijouk@hotmail.com'),
(106, 'Rachel Green', 36294628777, to_date('12/01/1980','DD/MM/YYYY'), 978761234, 'central perk, 1000', 'rachelerosshotmail.com'),
(107, 'Milene Cardoso', 75733290954, to_date('01/10/2004','DD/MM/YYYY'), 99954320, 'Osório, 7777', 'micardoso7@gmail.com'),
(108, 'Thiago Fritz', 04607128366, to_date('24/09/1996','DD/MM/YYYY'), 97077079, 'sao paolo, 3333', 'fritz@gmail.com');

INSERT INTO carro (codCarro, marca, modelo, valor, anoFabricacao) VALUES
(070, 'Audi', 'R8', 1950000, 2007),
(071, 'Nissan', 'Skyline R34 Gtr', 1200000, 2000),
(072, 'Nissan', 'Skyline R35 Gtr', 950000, 2007),
(073, 'Mitsubishi', 'Eclipse', 85900, 1989),
(074, 'Honda', 'Civic EJ1', 33900, 1995),
(075, 'Volkswagen', 'Jetta Gli', 190000, 2019),
(076, 'BMW', 'M3 Gtr', 758000, 2001),
(077, 'Toyota', 'Supra', 350000, 2002),
(078, 'Audi', 'TT', 442900, 1998),
(079, 'Porsche', '911', 797000, 2015),
(080, 'Volkswagen', 'Gol quadrado', 9000, 2000),
(081, 'Fiat', 'Uno', 60000, 2017),
(082, 'Fiat', 'Palio Weekend', 44000, 20100),
(083, 'Nissan', '350z', 115000, 2001),
(084, 'VolksWagen', 'Fox', 60000, 2020),
(085, 'Peugeot', '208', 88990, 2012),
(086, 'Honda', 'Fit', 42900, 2013),
(087, 'Hyundai', 'HB20S 1.6', 51900, 2017),
(088, 'Ford',  'Fusion 2.0', 75000, 2015),
(089, 'Fiat', 'Cronos', 90390, 2022),
(090, 'Renault', 'Kwid', 68590, 2017), 
(091, 'Ford', 'Maverick', 120000, 1970),
(092, 'Fiat', 'Mobi', 67000, 2016),
(093, 'Jeep', 'Renegade', 100000, 2022),
(094, 'Suzuki', 'Jimny', 122990, 2022),
(095, 'Jeep', 'Wrangler Rubicon', 459990, 2022);

INSERT INTO venda (codCarro, codVenda, anoFabricacao, valorVenda, codFuncionario, codCliente) VALUES 
(070, 200, 2021, 570000, 001, 101),
(071, 201, 2020, 56000, 002, 102), 
(072, 203, 2022, 96000, 003, 103),
(073, 204, 2022, 120000, 004, 104), 
(074, 205, 2022, 450000, 006, 105)

INSERT INTO proposta (codproposta, codCarro, codFuncionario, codCliente, valorInicial, valorFinal, dataVenda) VALUES
(01, 070, 001, 101, 574990, 570000, to_date('22/04/2022', 'DD/MM/YYYY')),
(02, 071, 002, 102, 60000, 56000, to_date('16/02/2021', 'DD/MM/YYYY')),
(03, 072, 003, 103, 100000, 96000, to_date('04/09/2022', 'DD/MM/YYYY')),
(04, 090, 001, 108, 68590, 67500, to_date('08/01/2020','DD/MM/YYYY'));

--Uma Consulta que envolva dados de pelo menos duas tabelas;
SELECT f.nome, count(codproposta) FROM funcionario f INNER JOIN proposta p
    ON f.codfuncionario=p.codfuncionario
    GROUP BY f.nome
