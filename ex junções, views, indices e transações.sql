--DROPS
DROP TABLE IF EXISTS ItemVenda;
DROP TABLE IF EXISTS NotaFiscal;
DROP TABLE IF EXISTS Produto;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Funcionario;
DROP TABLE IF EXISTS Departamento;

CREATE TABLE  Cliente 
(	CODCLIENTE serial, 
	NOME VARCHAR(100) NOT NULL, 
	CPF VARCHAR(15) UNIQUE, 
	EMAIL VARCHAR(50), 
	 CONSTRAINT "ClientePK" PRIMARY KEY (CODCLIENTE) 
) ;
CREATE TABLE  Departamento 
(	CODDEPARTAMENTO serial, 
	NOME VARCHAR(100), 
	 CONSTRAINT "DepartamentoPK" PRIMARY KEY (CODDEPARTAMENTO)
) ;
CREATE TABLE Funcionario
(
	codFuncionario serial,
	codDepartamento integer,
	CPF varchar(15) UNIQUE, 
	Nome varchar(50) NOT NULL,
	Salario numeric(7,2) NOT NULL ,
	DataNascimento date,
	Sexo varchar(1),
	Login varchar(50) UNIQUE,
	Senha text,
	codChefe int,
	CONSTRAINT "FuncionarioPK" PRIMARY KEY (codFuncionario),
	CONSTRAINT "CheckSexo" CHECK (Sexo = 'M' or Sexo = 'F'),
	CONSTRAINT "FuncionarioFKDepartamento" FOREIGN KEY (codDepartamento)
		REFERENCES Departamento (codDepartamento)
		on delete set null
		on update cascade,
	CONSTRAINT "FuncionarioFKChefe" FOREIGN KEY (codChefe)
		REFERENCES Funcionario (codFuncionario)
		on delete set null
		on update cascade
);

CREATE TABLE NotaFiscal
(
  codNotaFiscal serial,
  dataVenda date,
  codCliente integer,
  codFuncionario integer,
  CONSTRAINT "NotaFiscalPK" PRIMARY KEY (codNotaFiscal),
  CONSTRAINT "NotaFiscalFKCliente" FOREIGN KEY (codCliente)
      REFERENCES cliente (codcliente) ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT "NotaFiscalFKFuncionario" FOREIGN KEY (codFuncionario)
      REFERENCES funcionario (codFuncionario) ON UPDATE CASCADE ON DELETE SET NULL
);

CREATE TABLE Produto
(
	codProduto serial,
	descricao varchar(100) NOT NULL,
	precoUnit numeric(9,2) NOT NULL,
	qtdeEstoque integer NOT NULL,
	CONSTRAINT "ProdutoPK" PRIMARY KEY (codProduto)
);
CREATE TABLE ItemVenda
(
	codProduto integer,
	codNotaFiscal integer,
	quantidade numeric(6,3) NOT NULL,
	precoUnitVenda numeric(9,2) NOT NULL,

	CONSTRAINT "ItemVendaPK" PRIMARY KEY (codProduto, codNotaFiscal),
	CONSTRAINT "ItemVendaFKProduto" FOREIGN KEY (codProduto) 
		REFERENCES Produto (codProduto) ON DELETE SET NULL ON UPDATE CASCADE,
	CONSTRAINT "ItemVendaFKNotaFiscal" FOREIGN KEY (codNotaFiscal) 
		REFERENCES NotaFiscal (codNotaFiscal) 
);


--inserts	
--clientes
INSERT INTO cliente (nome,cpf,email)VALUES
( 'Maria Julia', '08736201', 'mariah1234@gmail.com'),
( 'Carlos Andr?? Cadutra', '8723436201', 'cadutra12@yahoo.com.br'),
( 'Jose Geraldo', '092887221', 'zegege3@hotmail.com'),
( 'Rita Maria Julia Toschini', '01225687321', 'ritinhatoschini@hotmail.com'),
( 'Adriano Carlos Fonseca', '98222187321', 'fonsecao88@gmail.com'),
( 'Paulo Lopes', '121232521', 'fonsecao88@gmail.com'),
( 'Jos?? Bruno L??zaro', '45698762433', 'lazarento@hotmail.com');

--deptos
INSERT INTO departamento (nome) VALUES ('TI'),('Marketing'),('Vendas'),('Gest??o'),('Produ????o'),('novo depto');

--funcionarios
INSERT INTO funcionario (codDepartamento,codChefe,CPF,nome,salario,datanascimento,sexo,login,senha) VALUES 
--1
(4,null,'092887221', 'Jose Geraldo', 18765, to_date('02/03/1982','DD/MM/YYYY'), 'M', 'zeh', md5('zehS2')), 	
--2
(1,1,'08736201','Maria Julia', 3765, to_date('02/04/1985','DD/MM/YYYY'), 'F', 'mariah', md5('mariasinha')), 
--3
(4,null,'05722201','Sergio Boss', 15000, to_date('01/12/1975','DD/MM/YYYY'), 'M', 'sBoss', md5('TheBoss')),
--4
(2,1,'765527221', 'Jean Valjean', 4560.7, to_date('10/11/1950','DD/MM/YYYY'), 'M', 'jan', md5('tupeton')),
--5
(5,1,'12998762', 'Ricardo Tote', 1770, to_date('20/09/1997','DD/MM/YYYY'), 'M', 'Cadu', md5('ricardim')),
--6
(4,1,'828722121', 'Geraldo Julio Sperafico', 8765, to_date('28/02/1945','DD/MM/YYYY'), 'M', 'gjs', md5('chefinho')),
--7
(3,3,'121232521', 'Paulo Lopes', 5600, to_date('15/08/1999','DD/MM/YYYY'), 'M', 'lopes', md5('lopespower')),
--8
(5,5,'0344617221','Carla Montenegro', 7000.23,to_date('02/03/1995','DD/MM/YYYY'),'F','carla',md5('gatinha95')),	
--9
(3,7,'09232287221', 'Josefa F??tima', 4666, to_date('12/07/1970','DD/MM/YYYY'), 'F', 'josefa', md5('zehfinha')),
--10
(1,1,'45698762433', 'Jos?? Bruno L??zaro', 4200, to_date('12/07/2000','DD/MM/YYYY'), 'M', 'zeLaser', md5('lazarento')),
--11
(null,7,'09232547621', 'Josefa sem depto', 4900, to_date('12/07/1979','DD/MM/YYYY'), 'F', 'semAmiga', md5('semAmiga'));


INSERT INTO produto (descricao, precounit, qtdeEstoque) VALUES 
('achocolatado nescau', 6.7, 100),			--1
('leite integral Damby', 3.2, 300),			--2
('banana prata kg', 4.74, 50),				--3
('tomate gaucho kg', 8.21, 40),				--4
('ma??a argentina kg', 10.15, 60),			--5
('refrigerante coca-cola lata', 2.85, 500),		--6
('refrigerante coca-cola 2l', 5.15, 400),		--7
('refrigerante guaran?? antartica lata', 2.75, 600),	--8
('refrigerante sukita 2l', 5, 450),			--9
('??gua mineral ??gua da pedra 500ml', 2.15, 1000),	--10
('p??o franc??s "little cacete" kg', 5.85, 200),		--11
('detergente l??quido limpol', 3.15, 240),		--12
('shampo  Clear Men do CR7', 10.75, 30),		--13
('creme dental sorriso 4d', 4.99, 25),			--14
('biscoito nesfit sabor chocolate', 2.85, 70),		--15
('Smart TV LED 32" HD Samsung 32J4300 ', 1599.90, 8),	--16 
('papel higi??nico neve 40m c/4', 6.15, 48),		--17
('pen drive kingston 4GB', 40.99, 10),			--18 
('cerveja coruja viva weiss', 15.99, 15),		--19
('refrigerante guaran?? biri 2l', 1.99, 55),		--20
('erva mate tacapi sabor canela 500g', 7.99, 45); 	--21


--insert de 10 vendas

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '2 years', 6,1);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(1,1,1,6.5), (1,2,2,3.0), (1,4,1.23,10.5);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 year 62 days', 6,2);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (2,3,1.54,	4.22),(2,6,4, 2.39);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '55 days', 5,3);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(3,7,3, 4.99),(3,10,6, 1.99),(3,11,0.54, 5.85),(3,2,3, 2.65);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '50 days', 8,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(4,12,1, 2.95),(4,14,3, 3.99),(4,13,2, 9.75),(4,21,1, 6.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '45 days', 6,5);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(5,20,10, 0.99), (5,15,3,  2.85), (5,19,2,  15.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '40 days', 5,6);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(6,16,1, 1699.90),(6,18,2, 45.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '30 days', 8,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (7,20,12, 1.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 year 25 days', 6,1);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(8,2,12, 3.2), (8,11,0.3, 5.85), (8,21,1, 7.99);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '10 days', 6,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(9,6,2, 2.80),(9,7,3, 4.75),(9,9,1, 4.5);

INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES 
(current_date - interval '1 day', 3,4);
INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES 
(10,6,2, 2.80),(10,2,3, 3.10),(10,21,2, 8.49);

--a O nome dos funcion??rios e de seus respectivos departamentos
SELECT f.nome AS funcionario, d.nome AS departamento FROM funcionario f LEFT OUTER JOIN departamento d 
	ON d.coddepartamento=f.coddepartamento
	
--b Quantas diferentes pessoas (todos seus dados) existem no banco de dados (clientes e funcion??rios)
SELECT * FROM funcionario f FULL JOIN cliente c 
	ON c.codcliente=f.codfuncionario

SELECT * FROM funcionario FULL JOIN cliente USING (cpf, nome)

--c O item 1.j agrupado por nome do departamento e ordenado pelo nome do departamento para funcion??rios do
--sexo masculino com sal??rio maior que 2000

--j. A m??dia salarial e o maior e menor sal??rio dos funcion??rios
SELECT d.nome, avg(salario) AS media_salarial, min(salario) AS menor_salario, max(salario) AS maior_salario
	FROM funcionario f INNER JOIN departamento d ON d.coddepartamento=f.coddepartamento
	WHERE sexo='M' AND salario>=2000
	GROUP BY d.nome
	
	
--d A descri????o dos produtos bem como o n??mero de itens que foram vendidos, ordenado pelo n??mero de itens
--que foram vendidos.
SELECT descricao, COALESCE (sum(quantidade), 0) as qtdeVendida FROM produto p LEFT JOIN ITEMVENDA iv
	ON p.codproduto=iv.codproduto
	GROUP BY p.codproduto 
	ORDER BY qtdeVendida desc;
	
--e A descri????o e n??mero de vezes que cada produto foi vendido, ordenado pelo n??mero de vezes que foi
--vendido.
SELECT * FROM produto
SELECT count(*) AS qtde_vendida, descricao 
	FROM produto p LEFT OUTER JOIN itemvenda iv
	ON p.codProduto = iv.codProduto 
	GROUP BY descricao 
	ORDER BY count(*)desc;
	
SELECT p.codproduto, p.descricao, count(iv.codproduto) as vezes_vendido
	FROM produto p LEFT JOIN itemvenda iv
	ON p.codproduto = iv.codproduto
	GROUP BY p.codproduto
	ORDER BY vezes_vendido
	
--f A listas dos clientes que mais vezes compram na loja. Nome e total de compras ordenado pelo total de compras.
SELECT c.nome, c.codcliente, 
	'R$ '||round(coalesce(sum(quantidade*precounitvenda), 0),2) AS total
	FROM notafiscal nf INNER JOIN itemvenda iv
		USING (codnotafiscal)
	RIGHT JOIN cliente c USING (codcliente)
	GROUP BY c.codcliente
	ORDER BY total desc

--g A lista dos funcion??rios que mais vendas realizaram. Nome e total de vendas realizadas ordenado pelo total de compras.
SELECT f.nome, count(nf.codFuncionario) AS vendas FROM notafiscal nf
	INNER JOIN funcionario f
	ON nf.codFuncionario = f.codFuncionario 
	GROUP BY f.nome 
	ORDER BY count(nf.codCliente)desc;
	
--h. A lista de dos departamentos e o total em vendas (R$) realizadas por cada departamento.
SELECT d.nome, 'R$ '||round(coalesce(sum(quantidade*precounitvenda), 0)) as total
	FROM itemvenda iv
	INNER JOIN notafiscal nf USING (codnotafiscal)
	INNER JOIN funcionario f USING (codfuncionario)
	RIGHT JOIN departamento d USING (coddepartamento)
		GROUP BY d.coddepartamento
	
--i. Sobre os clientes que s??o funcion??rios mostrar o nome, o total em vendas realizadas (R$) e o total em compras realizadas (R$)
--j. O nome e a m??dia em compras (R$) para os clientes que compraram em m??dia acima de R$30 em cada compra.
--k. Nome do cliente, do funcion??rio e o total da compra para vendas realizadas no ??ltimo m??s.

--cl??usula when
SELECT count(iv.codproduto) AS qtde_vendida, descricao,
    CASE
        WHEN count(*) >10 THEN 'muito vendido'
        WHEN count(*) >=5  THEN 'vendas normais'
        WHEN count(*) >=1 THEN 'pouco vendido'
        WHEN count(*) = 0 THEN 'nunca vendido'
        END AS vendas
	FROM produto p INNER JOIN itemvenda iv
	USING (codproduto) 
    GROUP BY descricao

--exerc??cios view, transa????es e ??ndices

--1) Crie uma view que liste os dados de funcion??rios (nome, cpf, salario, dataNascimento, sexo e nome do departamento)
CREATE VIEW func_depto AS
	(SELECT f.nome, f.cpf, f.salario, f.dataNascimento, f.sexo, d.nome AS departamento FROM funcionario f LEFT OUTER JOIN departamento d 
	ON d.coddepartamento=f.codfuncionario);
SELECT * FROM func_depto;
drop view func_depto

--2) Crie uma view que liste os dados de funcion??rios (nome, cpf, salario, dataNascimento, 
--sexo, nome do departamento e nome do chefe quando existir)     
CREATE VIEW func_chefe ("funcionario", "cpf", "salario", "data nascimento", "sexo", "departamento", "chefe") AS
    (SELECT f.nome, f.cpf, f.salario, f.datanascimento, f.sexo, d.nome, chefe.nome
    FROM funcionario f LEFT OUTER JOIN departamento d ON f.coddepartamento=d.coddepartamento
    LEFT OUTER JOIN funcionario chefe ON f.codchefe=chefe.codfuncionario);
    
SELECT * FROM func_chefe
drop view func_chefe
    
--3) Crie uma view que liste o n??mero de compras e o total em reais comprado por cada cliente 
--(o nome e cpf do cliente)
CREATE VIEW compras ("cliente", "cpf", "codcliente", "numero_compras", "total") AS
    (SELECT c.nome, c.cpf, c.codcliente, count(iv.codproduto) AS numero_compras,
	'R$ '||round(coalesce(sum(quantidade*precounitvenda), 0),2) AS total
	FROM notafiscal nf INNER JOIN itemvenda iv
		USING (codnotafiscal)
	RIGHT JOIN cliente c USING (codcliente)
	GROUP BY c.codcliente)
    
SELECT * FROM compras
drop view compras

--4) Fa??a uma consulta que liste o nome dos funcion??rios e departamentos. Fa??a uma view para cada item de listagem pedido:
--a. Apenas funcion??rios alocados em um departamento e departamentos com funcion??rios.
CREATE VIEW seila ("funcionario", "departamento") AS
	(SELECT f.nome, d.nome FROM funcionario f 
					 INNER JOIN departamento d on d.coddepartamento=f.coddepartamento)
					 
SELECT * FROM seila
drop view seila

--b. Todos funcion??rios e apenas departamentos com funcion??rios.
CREATE VIEW louis ("funcionario", "departamento") AS
	(SELECT f.nome, d.nome FROM funcionario f 
	 LEFT OUTER JOIN departamento d on d.coddepartamento=f.codfuncionario)
					 
SELECT * FROM louis
drop view louis

-- X c. Apenas funcion??rios alocados em um departamento e todos os departamentos.
SELECT f.nome, d.nome FROM funcionario f RIGHT OUTER JOIN departamento d on f.codfuncionario=d.coddepartamento --right?

--d. Todos funcion??rios e todos departamentos.
CREATE VIEW taylor ("funcionario", "deparamento") AS
	(SELECT f.nome, d.nome FROM funcionario f FULL JOIN departamento d ON f.codfuncionario=d.coddepartamento)
	
SELECT * FROM taylor
drop view taylor

--Ap??s criar as views, insira 2 departamentos sem funcion??rios e 2 funcion??rios sem vinculo a um departamento e
--observe as mudan??as nas views.

--5) O que s??o ??ndices, qual sua utilidade?
--?? uma estrutura complementar de uma coluna da tabela, ela torna a busca por um elemento da coluna mais eficiente, e
--?? ??til para campos que aparecem muitas vezes nas condi????es de busca.

--6) Considerando a tabela Funcionario, cite uma coluna que ?? candidata a ter um ??ndice e uma que n??o deve ter um ??ndice.
--Ap??s crie o ??ndice para a coluna escolhida.
--Uma coluna que ?? candidata pode ser nome (poderia ser codFuncionario, mas as chaves prim??rias j?? tem ??ndice); uma coluna 
--que n??o ?? recomendado seria sexo, pois n??o espalha quase nada.
CREATE INDEX in_nome ON funcionario(nome)
DROP INDEX in_nome

--7) Um sistema que utiliza o banco de dados apresentado realiza muitas pesquisas com filtro pela data de emiss??o de cada
--nota fiscal, essas consultas t??m apresentado certa lentid??o. Que solu????o voc?? prop??e para solucionar o problema (informe
--tamb??m o comando SQL para efetivar a solu????o)?
--poderia ser criado um indice para a coluna dataVenda da tabela NotaFiscal. O comando para a solu????o ??: 
CREATE INDEX data_venda ON notafiscal(dataVenda)

--8) Como ?? feito o controle de transa????es em Banco de dados, com quais comandos? Explique por que isso ?? ??til.
--O controle ?? feito atrav??s de comandos de come??o, fim e para voltar um estado de ma transa????o. Eles s??o:
BEGIN TRANSACTION; ROLLBACK WORK; COMMIT WORK.

--9) A venda de um conjunto de produtos ?? considerada uma transa????o ??nica, ou seja, ou a venda dos produtos ?? realizada ou
--n??o. Crie uma transa????o que realize a compra dos produtos de c??digo 3 (quantidade 5), 5 (quantidade 3) e 8 (quantidade 2)
--feita pelo funcion??rio de c??digo 3 e cliente de c??digo 2.
BEGIN TRANSACTION
	INSERT INTO notafiscal (datavenda, codfuncionario, codcliente) VALUES (current_date - interval '30 days', 3, 2);
	INSERT INTO itemVenda (codnotafiscal, codproduto, quantidade, precoUnitVenda) VALUES (9, 3, 5, 2.80);
	inset itemvenda
	inset itemvenda
	update produto
	update produto
	update produto
COMMIT WORK;
