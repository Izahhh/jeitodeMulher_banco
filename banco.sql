-- TABELAS


CREATE TABLE salao (

id_salao SERIAL PRIMARY KEY,

nome VARCHAR(100),

telefone VARCHAR(20),

email VARCHAR(100)

);



CREATE TABLE cliente (

id_cliente SERIAL PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

telefone VARCHAR(20),

email VARCHAR(100)

);



CREATE TABLE profissional (

id_profissional SERIAL PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

telefone VARCHAR(14) NOT NULL UNIQUE,

cpf CHAR(11) NOT NULL UNIQUE,

email VARCHAR(100) NOT NULL UNIQUE

);



CREATE TABLE servico (

id_servico SERIAL PRIMARY KEY,

nome VARCHAR(100),

preco NUMERIC(10,2),

duracao_min INT

);



CREATE TABLE produto (

id_produto SERIAL PRIMARY KEY,

nome VARCHAR(100) NOT NULL,

preco NUMERIC(10,2) NOT NULL CHECK (preco > 0),

categoria VARCHAR(60) NOT NULL,

estoque INT NOT NULL,

dt_criacao DATE DEFAULT CURRENT_DATE

);



CREATE TABLE agendamento (

id_agendamento SERIAL PRIMARY KEY,

id_cliente INT REFERENCES cliente(id_cliente),

id_profissional INT REFERENCES profissional(id_profissional),

id_servico INT REFERENCES servico(id_servico),

data_hora TIMESTAMP,

status VARCHAR(15),

forma_pagamento VARCHAR(10)

);





-- INSERTS



INSERT INTO cliente (nome, telefone, email) VALUES

('Ana Souza', '11988880001', 'ana@email.com'),

('Bruno Lim', '11988880002', 'bruno@email.com'),

('Carla Mendes', '11988880003', NULL);



INSERT INTO profissional (nome, telefone, cpf, email) VALUES

('Izabella', '11964828488', '24353646576', 'izabella@uni9.edu.br'),

('Sabrina', '11917320837', '77389402561', 'sabrina@uni9.edu.br'),

('Vitoria', '11945633382', '11472289101', 'vitoria@uni9.edu.br'),

('Giovana', '11988421785', '55372819201', 'giovana@uni9.edu.br');



INSERT INTO servico (nome, preco, duracao_min) VALUES

('Corte feminino', 90.00, 60),

('Corte masculino', 50.00, 30),

('Coloração', 180.00, 120),

('Barba', 35.00, 25);



INSERT INTO agendamento (id_cliente, id_profissional, id_servico, data_hora, status, forma_pagamento) VALUES

(1, 1, 3, '2026-10-16 09:00:00', 'agendado', NULL),

(2, 2, 2, '2026-10-16 10:00:00', 'agendado', NULL),

(3, 1, 1, '2026-10-10 14:00:00', 'concluido', 'pix'),

(2, 2, 4, '2026-10-12 11:00:00', 'concluido', 'dinheiro');



INSERT INTO produto (nome, preco, categoria, estoque) VALUES

('Kit Stages Nutrition Shampoo e Condicionador 1L + Máscara 500g', 295.84, 'Kit Nutrition', 20),

('Cadiveu Quartzo Shine Kit Shampoo + Condicionador + Óleo', 324.75, 'Kit Cadiveu', 20),

('Kit Deva Curl Cacheados Super Tratados', 379.70, 'Kit Deva Curl', 20),

('Wella Invigo Nutri Enrich Kit Sh + Cond + Másc Original', 548.96, 'Shampoos e Condicionadores Wella', 20),

('Kit Kérastase Première Réparateur Trio 3 Produtos', 1028.30, 'Kit Tratamento Kérastase', 20)

-- Salão como dono de profissionais, produtos e agendamentos

ALTER TABLE profissional ADD COLUMN id_salao INT REFERENCES salao(id_salao);

ALTER TABLE produto ADD COLUMN id_salao INT REFERENCES salao(id_salao);

ALTER TABLE agendamento ADD COLUMN id_salao INT REFERENCES salao(id_salao);



-- Venda de produtos para clientes

CREATE TABLE venda (

id_venda SERIAL PRIMARY KEY,

id_cliente INT REFERENCES cliente(id_cliente),

id_profissional INT REFERENCES profissional(id_profissional),

data_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

forma_pagamento VARCHAR(10)

);



CREATE TABLE item_venda (

id_venda INT REFERENCES venda(id_venda),

id_produto INT REFERENCES produto(id_produto),

quantidade INT NOT NULL CHECK (quantidade > 0),

preco_unitario NUMERIC(10,2) NOT NULL,

PRIMARY KEY (id_venda, id_produto)

); 