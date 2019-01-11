create table cliente(
cod_cli serial primary key,
nome_cli varchar(30) not null,
dt_nasc_cli date not null,
cep_cli varchar(9) not null,
fone_cli varchar(12) not null

);

create table animal(
cod_ani serial primary key,
nome_ani varchar(30) not null,
peso_ani float not null,
descr_ani varchar(150) not null,
idade_ani int not null,
cod_cli int not null references cliente (cod_cli)
);

create table veterinario(
cod_vet serial primary key,
nome_vet varchar(30) not null,
dt_nasc_vet date not null,
cep_vet varchar(9) not null,
fone_vet varchar(12) not null 
);

create table exame(
cod_exa serial primary key,
nome_exa varchar(30) not null,
valor_exa float not null,
descr_exa varchar(150) not null
);

create table funcionario(
cod_fun serial primary key,
nome_fun varchar(30) not null,
dt_nasc_fun date not null,
fone_fun varchar(12) not null,
cep_fun varchar(9) not null,
cod_clin int not null references clinica(cod_clin)
);

create table medicamento(
cod_med serial primary key,
nome_med varchar(30) not null,
valor_med float not null
);


create table clinica(
cod_clin serial primary key,
nome_clin varchar(30) not null,
cep_clin varchar(9) not null,
valor_cli float not null
);

create table vet_clinica(
cod_vet_clin serial primary key,
cod_clin int not null references clinica(cod_clin),
cod_vet int not null references veterinario(cod_vet),
dt_ent date not null,
dt_sai date 
);

create table fun_clinica(
cod_fun_clin serial primary key,
cod_clin int not null references clinica(cod_clin),
cod_fun int not null references funcionario(cod_fun),
dt_ent date not null,
dt_sai date 
);

create table estoque(
cod_est serial primary key,
cod_clin int not null references clinica(cod_clin),
cod_med int not null references medicamento(cod_med),
qtd_med_est int not null
);

create table consulta(
cod_con serial primary key,
cod_ani int not null references animal(cod_ani),
cod_fun int not null references funcionario(cod_fun),
cod_vet_clin int not null references vet_clinica(cod_vet_clin),
descr_con varchar(150) not null,
sint_con varchar(50) not null,
diag_con varchar(50) not null,
valor_con float not null,
dt_hr timestamp
);

create table realiza_exame(
cod_rea_exa serial primary key,
cod_con int not null references consulta(cod_con),
cod_exa int not null references exame(cod_exa),
valor_rea_exa float not null
);

create table compra(
cod_com serial primary key,
cod_con int not null references consulta(cod_con),
cod_medic int not null,
dt_com timestamp not null,
valor_tot float not null
);

create table item_compra(
cod_com int not null references compra(cod_com),
cod_est int not null references estoque(cod_est),
qtd_item int not null,
valor_item float not null
);







-- Funçoes inserir

CREATE OR REPLACE FUNCTION inserir(varchar(20), int, int, int, varchar(255), varchar(255), varchar(255), float)
  RETURNS void AS $$
select 
case when $1 ilike 'Consulta' then inserir_consulta($2, $3, $4, $5, $6, $7, $8)
     
end
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION inserir(varchar(20), varchar(30), date, varchar(9), varchar(12))
  RETURNS void AS $$
select 
case when $1 ilike 'Cliente' then inserir_cliente($2, $3, $4, $5)
     when $1 ilike 'Veterinario' then inserir_veterinario($2, $3, $4, $5)
end
$$
LANGUAGE sql;



CREATE OR REPLACE FUNCTION inserir(varchar(20), int, int, int)
  RETURNS void AS $$
select 
case when $1 ilike 'Estoque' then inserir_estoque($2, $3, $4)
     
 end
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION inserir(varchar(20), varchar(50), varchar(9), float)
  RETURNS void AS $$
select 
case when $1 ilike 'Clinica' then inserir_clinica($2, $3, $4)
     
 end
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION inserir(varchar(20), int, int, date)
  RETURNS void AS $$
select 
case when $1 ilike 'Vet_clinica' then inserir_vet_clinica($2, $3, $4)
     when $1 ilike 'Fun_clinica' then inserir_fun_clinica($2, $3, $4)
     
 end
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION inserir(varchar(20), int, int, float)
  RETURNS void AS $$
select 
case when $1 ilike 'Realiza_exame' then inserir_realiza_exame($2, $3, $4)
     when $1 ilike 'Compra' then inserir_compra($2, $3, $4)
     
 end
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION inserir(varchar(20), int, int, int, float)
  RETURNS void AS $$
select 
case when $1 ilike 'item_compra' then inserir_item_compra($2, $3, $4, $5)
     
 end
$$
LANGUAGE sql;


CREATE OR REPLACE FUNCTION inserir(varchar(20), varchar(20), float, varchar(50), int, int)
  RETURNS void AS $$
select 
case when $1 ilike 'Animal' then inserir_animal($2, $3, $4, $5, $6)
     when $1 ilike 'Exame' then inserir_exame($2, $3, $4)
     when $1 ilike 'Medicamento' then inserir_medicamento($2, $3)
end
$$
LANGUAGE sql;





-- Inserindo nas tabelas

CREATE OR REPLACE FUNCTION inserir_consulta(int, int, int, varchar(255), varchar(255), varchar(255), float)
  RETURNS void AS $$
Begin
	INSERT INTO Consulta (cod_ani, cod_fun, cod_vet_clin, descr_con, sint_con, diag_con, valor_con, dt_hr) VALUES($1, $2, $3, $4, $5, $6, $7, 'now');
End
$$
LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION inserir_veterinario(varchar(30), date, varchar(9), varchar(12))
  RETURNS void AS $$
Begin
	INSERT INTO Veterinario (nome_vet, dt_nasc_vet, cep_vet, fone_vet) VALUES($1, $2, $3, $4);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_cliente(varchar(30), date, varchar(9), varchar(12))
  RETURNS void AS $$
Begin
	INSERT INTO Cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) VALUES($1, $2, $3, $4);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_estoque(int, int, int)
  RETURNS void AS $$
Begin
	INSERT INTO Estoque VALUES(default, $1, $2, $3, $4);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_clinica(varchar(50), varchar(9), float)
  RETURNS void AS $$
Begin
	INSERT INTO Clinica VALUES(default, $1, $2, $3);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_vet_clinica(int, int, date)
  RETURNS void AS $$
Begin
	INSERT INTO Vet_clinica VALUES($1, $2, $3, null);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_fun_clinica(int, int, date)
  RETURNS void AS $$
Begin
	INSERT INTO Fun_clinica VALUES($1, $2, $3, null);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_realiza_exame(int, int, float)
  RETURNS void AS $$
Begin
	INSERT INTO Realiza_exame VALUES(default, $1, $2, $3);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_compra(int, int, float)
  RETURNS void AS $$
Begin
	INSERT INTO Compra VALUES(default, $1, $2, $3);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_item_compra(int, int, int, float)
  RETURNS void AS $$
Begin
	INSERT INTO Item_compra VALUES(default, $1, $2, $3, $4);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_animal(varchar(20), float, varchar(50), int, int)
  RETURNS void AS $$
Begin
	INSERT INTO Animal VALUES(default, $1, $2, $3, $4, $5);
	
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_exame(varchar(20), float, varchar(50))
  RETURNS void AS $$
Begin
	INSERT INTO Exame VALUES(default, $1, $2, $3);
	raise info 'Exame registrado.';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_medicamento(varchar(20), float)
  RETURNS void AS $$
Begin
	INSERT INTO medicamento VALUES(default, $1, $2);
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_cliente(varchar(30), date, varchar(9), varchar(12))
  RETURNS void AS $$
Begin
	INSERT INTO Cliente VALUES(default, $1, $2, $3, $4);
	raise info 'Cliente criado';
End
$$
LANGUAGE 'plpgsql';







---- Inserts  




select inserir('Consulta', 1, 1, 1, 'isso que ocorreu', 'tava doente', 'tava mesmo', 11.5);
select inserir('Veterinario', 'rukia', '1990-05-05', '64000-000', '99999-9999');
select inserir('Cliente', 'Naruto','1995-10-10', '64000-000', '99999-9999');
insert into cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) values ('Naruto','1995-10-10', '64000-000', '99999-9999')


--inserção em animal, exame, medicamento


select inserir('Clinica', 'Leos pet', '64000-000', 50.00);

select inserir('Animal', 'Akamaru', 50, 'grande porte', 5, 1);
select inserir('Exame', 'raio-X', 150.00, 'fazer isso', null, null);
select inserir('Medicamento', 'nome_medicamento', 15.00, null, null, null);

insert into cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) values ('Naruto','1995-10-10', '64000-000', '99999-9999') 


