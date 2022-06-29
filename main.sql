create extension if not exists "uuid-ossp";

DROP TABLE investimentos;

create table Investidores (
  id UUID primary key default uuid_generate_v4(),
  nome varchar(256) not null,
  cnpj varchar(18) not null,
  endereco varchar(256) not null
);


create table Startup (
  id UUID primary key default uuid_generate_v4(),
  razaoSocial varchar(256) not null,
  cnpj varchar(18) not null,
  email varchar(256),
  nomeFantasia varchar(256),
  endereco varchar(256) not null
);


create table Investimentos (
  id UUID primary key default uuid_generate_v4(),
  capital decimal(9,2) not null,
  investidor_id UUID not null,
  startup_id UUID not null,
  CONSTRAINT fk_investidor FOREIGN KEY(investidor_id) REFERENCES Investidores(id),
  CONSTRAINT fk_startup FOREIGN KEY(startup_id) REFERENCES Startup(id)
);

create table Cliente (
    id UUID primary key default uuid_generate_v4(),
	razaoSocial varchar(256) not null,
  	cnpj varchar(18) not null,
  endereco varchar(256) not null,
  	startup_id UUID not null,
  	CONSTRAINT fk_startup FOREIGN KEY(startup_id) REFERENCES Startup(id)
);

create table Pagamento (
	idPagamento UUID primary key default uuid_generate_v4(),
  	precoTotal decimal(9,2) not null,
  	dataPagamento timestamp not null,
  	projeto_id UUID not null,
  	cliente_id UUID not null,
  	CONSTRAINT fk_projeto FOREIGN KEY(projeto_id) REFERENCES Cliente(id),
  	CONSTRAINT fk_cliente FOREIGN KEY(cliente_id) REFERENCES Projeto(id)
);


create table Projeto (
    id UUID primary key default uuid_generate_v4(),
	nome varchar(256) not null,
  	nome_time varchar(256) not null,
  startup_id UUID not null,
  	CONSTRAINT fk_startup FOREIGN KEY(startup_id) REFERENCES Startup(id)
);

create table Produto (
    id UUID primary key default uuid_generate_v4(),
	nome varchar(256) not null,
  	valor varchar(256) not null,
  	projeto_id UUID not null,
  	CONSTRAINT fk_projeto FOREIGN KEY(projeto_id) REFERENCES Projeto(id)
);

create table Funcionario (
    id UUID primary key default uuid_generate_v4(),
	nome varchar(256) not null,
  	cpf varchar(14) not null,
  	endereco varchar(256) not null
  	cargo varchar(256) not null,
  	salario decimal(9,2) not null,
  	projeto_id UUID not null,
  	CONSTRAINT fk_projeto FOREIGN KEY(projeto_id) REFERENCES Projeto(id)
);


curl "$REPLIT_DB_URL?prefix=key"
