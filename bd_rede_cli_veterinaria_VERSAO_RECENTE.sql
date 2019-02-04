create table cliente(
cod_cli serial primary key,
nome_cli varchar(30) not null,
dt_nasc_cli date not null,
cep_cli varchar(9) not null,
fone_cli varchar(12) not null
);
select * from cliente


create table animal(
cod_ani serial primary key,
nome_ani varchar(30) not null,
peso_ani float not null,
descr_ani varchar(150) not null,
idade_ani int not null,
cod_cli int not null references cliente (cod_cli),
classific_ani varchar(30)
);

--drop table animal cascade

select * from animal

create table idade(
cod_ani int not null references animal (cod_ani),
dia_ani int,
mes_ani int,
ano_ani int
);
--drop table idade cascade

create table veterinario(
cod_vet serial primary key,
nome_vet varchar(30) not null,
dt_nasc_vet date not null,
cep_vet varchar(9) not null,
fone_vet varchar(12) not null 
);

select * from veterinario
insert into veterinario values (default,'Murilo', '1995-08-13', '64005-730', '32145566')


create table exame(
cod_exa serial primary key,
nome_exa varchar(30) not null,
valor_exa float not null
);
--drop table exame cascade


select * from exame
insert into exame values (default,'Raio-x', 200.00)

create table funcionario(
cod_fun serial primary key,
nome_fun varchar(30) not null,
dt_nasc_fun date not null,
fone_fun varchar(12) not null,
cep_fun varchar(9) not null,
cod_clin int not null references clinica(cod_clin)
);

select * from funcionario
insert into funcionario values (default, 'Jefferson', '1995-08-13', '32145566', '64005-730',4)

create table medicamento(
cod_med serial primary key,
nome_med varchar(30) not null,
valor_med float not null
);


select * from medicamento
insert into medicamento values (default, 'dipirona', 5.00)
insert into medicamento values (default, 'aspirina', 5.25)

create table clinica(
cod_clin serial primary key,
nome_clin varchar(30) not null,
cep_clin varchar(9) not null,
valor_cli float not null
);




select * from clinica
insert into clinica values (default, 'Luscas', '64000-00', 60.50)

create table vet_clinica(
cod_vet_clin serial primary key,
cod_clin int not null references clinica(cod_clin),
cod_vet int not null references veterinario(cod_vet),
dt_ent date not null,
dt_sai date 
);

select * from vet_clinica
insert into vet_clinica values (default,1, 1,'2018-12-7')


create table fun_clinica(
cod_fun_clin serial primary key,
cod_clin int not null references clinica(cod_clin),
cod_fun int not null references funcionario(cod_fun),
dt_ent date not null,
dt_sai date 
);


select * from fun_clinica
insert into fun_clinica values (default,1, 1,'2018-12-1')


create table estoque(
cod_est serial primary key,
cod_clin int not null references clinica(cod_clin),
cod_med int not null references medicamento(cod_med),
qtd_med_est int not null
);


select * from estoque
insert into estoque values (default, 4, 1,300)

create table consulta(
cod_con serial primary key,
cod_ani int not null references animal(cod_ani),
cod_fun_clin int not null references fun_clinica(cod_fun_clin),
cod_vet_clin int not null references vet_clinica(cod_vet_clin),
descr_con varchar(150) not null,
sint_con varchar(50) not null,
diag_con varchar(50) not null,
valor_con float not null,
dt_hr timestamp
);

select inserir('Consulta', 18, 2, 1, 'descr','sintoma', 'diagnostico', 20);
select * from fun_clinica
select * from animal
--drop table consulta cascade

select * from consulta
insert into consulta values (default, 4, 2, 1, 'nao sei','sintoma', 'diagnostico', 300, now())

create table realiza_exame(
cod_rea_exa serial primary key,
cod_con int not null references consulta(cod_con),
cod_exa int not null references exame(cod_exa),
valor_rea_exa float not null
);


select * from realiza_exame
insert into realiza_exame values (default, 10, 1, 300)


create table compra(
cod_com serial primary key,
cod_con int not null references consulta(cod_con),
qtd_total_itens int not null,
dt_com timestamp not null,
valor_tot float not null
);

--drop table compra cascade


select * from compra
insert into compra values (default, 10, 1,now(),500)


create table item_compra(
cod_com int not null references compra(cod_com),
cod_est int not null references estoque(cod_est),
qtd_item int not null,
valor_item float not null
);

select * from item_compra
insert into item_compra values (1, 1, 1, 150)




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


CREATE OR REPLACE FUNCTION inserir(varchar(20), varchar(20), float, varchar(50), int, int, varchar(30))
  RETURNS void AS $$
select 
case when $1 ilike 'Animal' then inserir_animal($2, $3, $4, $5, $6, $7)
     when $1 ilike 'Exame' then inserir_exame($2, $3)
     when $1 ilike 'Medicamento' then inserir_medicamento($2, $3)
end
$$
LANGUAGE sql;


-- Inserindo nas tabelas

CREATE OR REPLACE FUNCTION inserir_consulta(int, int, int, varchar(255), varchar(255), varchar(255), float)
  RETURNS void AS $$
Begin
	INSERT INTO Consulta (cod_ani, cod_fun_clin, cod_vet_clin, descr_con, sint_con, diag_con, valor_con, dt_hr) VALUES($1, $2, $3, $4, $5, $6, $7, 'now');
	RAISE INFO 'Registro de consulta salvo com sucesso!';
End
$$
LANGUAGE 'plpgsql';



CREATE OR REPLACE FUNCTION inserir_veterinario(varchar(30), date, varchar(9), varchar(12))
  RETURNS void AS $$
Begin
	INSERT INTO Veterinario (nome_vet, dt_nasc_vet, cep_vet, fone_vet) VALUES($1, $2, $3, $4);
	RAISE INFO 'Veterinario salvo com sucesso!';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_cliente(varchar(30), date, varchar(9), varchar(12))
  RETURNS void AS $$
Begin
	INSERT INTO Cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) VALUES($1, $2, $3, $4);
	RAISE INFO 'Cliente salvo com sucesso!';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_estoque(int, int, int)
  RETURNS void AS $$
Begin
	INSERT INTO Estoque VALUES(default, $1, $2, $3, $4);
	RAISE INFO 'Inserção de produto realizado com sucesso!';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_clinica(varchar(50), varchar(9), float)
  RETURNS void AS $$
Begin
	INSERT INTO Clinica VALUES(default, $1, $2, $3);
	RAISE INFO 'Clinica salva!';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_vet_clinica(int, int, date)
  RETURNS void AS $$
Begin
	INSERT INTO Vet_clinica VALUES($1, $2, $3, null);
	RAISE INFO 'Sucesso!';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_fun_clinica(int, int, date)
  RETURNS void AS $$
Begin
	INSERT INTO Fun_clinica VALUES($1, $2, $3, null);
	RAISE INFO 'Sucesso!';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_realiza_exame(int, int, float)
  RETURNS void AS $$
Begin
	INSERT INTO Realiza_exame VALUES(default, $1, $2, $3);
	RAISE INFO 'Exame marcado.';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_compra(int, int, float)
  RETURNS void AS $$
Begin
	INSERT INTO Compra VALUES(default, $1, $2, $3);
	RAISE INFO 'Compra registrada.';
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_item_compra(int, int, int, float)
  RETURNS void AS $$
Begin
	INSERT INTO Item_compra VALUES(default, $1, $2, $3, $4);
	RAISE INFO 'Item adicionado.';
End	
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_animal(varchar(20), float, varchar(50), int, int, varchar(30))
  RETURNS void AS $$
Begin
	INSERT INTO Animal VALUES(default, $1, $2, $3, $4, $5, $6);
	
End
$$
LANGUAGE 'plpgsql';


CREATE OR REPLACE FUNCTION inserir_exame(varchar(20), float)
  RETURNS void AS $$
Begin
	INSERT INTO Exame VALUES(default, $1, $2);
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


----------------------------------------------------------------------------------------- DELETE -------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION delete_registro(tabela TEXT, coluna TEXT, valor TEXT)
RETURNS void AS $$

DECLARE
query TEXT;

	Begin		
		query:= 'DELETE FROM '|| $1 || ' WHERE '|| $2 || ' = ''' || $3 || ''';';

		EXECUTE query;
		RAISE INFO 'Todos os registros realacionados foram deletados';
	End
$$
LANGUAGE 'plpgsql';

select delete_registro('cliente', 'fone_cli', '99999-9999');



select nome from cliente
select * from veterinario

------------------------------------------------------------------------UPDATE -------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION update_registro(TEXT, TEXT, TEXT, TEXT, TEXT)
RETURNS void AS $$

DECLARE
query TEXT;

	Begin		
		query:= 'update  '|| $1 || ' set ' || $2 || ' = ''' || $3 || '''  where ' || $4 || ' = ''' || $5 || ''' ;';

		EXECUTE query;
		RAISE INFO 'Todos os registros realacionados foram atualizados';
	End
$$
LANGUAGE 'plpgsql';

select update_registro('cliente', 'nome_cli', 'Cody', 'nome_cli', 'Naruto');



------------------------------------------------------------------------------- TRIGGER PESO -----------------------------------------------------------------------------------
create or replace function validando_peso() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') then
	
			if new.classific_ani ilike 'criança' then

				if new.peso_ani > 100 and new.peso_ani <= 1000 then
					
					return new;
					
				else
					raise exception 'Animal ''criança'' com peso inválido';

				end if;
					
			elsif new.classific_ani ilike 'jovem' or new.classific_ani ilike 'adulto' then

				if new.peso_ani > 1 and new.peso_ani <= 50 then

					return new;
				else
					raise exception 'Animal ''jovem / adulto'' com peso inválido';
				
				end if;

			end if;

		end if;
								
	end;
	
$$language plpgsql;

create trigger valida_peso_animal before insert on animal for each row execute procedure validando_peso();

------------------------------------------------------------------------------- TRIGGER IDADE --------------------------------------------------------------------------

--create or replace function Xdefinindo_idade_em_dia_mes_ano() returns trigger as $$
--	begin
		
--		if (TG_OP = 'INSERT') then

--		
--			if new.classific_ani ilike 'criança' then

--				insert into idade values (new.cod_ani, new.idade_ani, null, null);
--				
--			elsif new.classific_ani ilike 'jovem' then
			
--				insert into idade values (new.cod_ani, null, new.idade_ani, null);
				
--			elsif new.classific_ani ilike 'adulto' then
			
--				insert into idade values (new.cod_ani, null, null, new.idade_ani);
							
--			end if;
			
--		return new;
--		end if;
	
--	end;
--$$ language plpgsql;

--create trigger gatilho_idade_em_d_m_a before insert on animal for each row execute procedure Xdefinindo_idade_em_dia_mes_ano();

--drop trigger definindo_idade_em_dias_mes_ano on idade


select inserir('Animal', 'Lote', 8, 'cachorro', 5, 4, 'jovem');

select * from animal

select * from idade

------------------------------------------------------------------------------------------trigger--Exame--------------------------------------------------------------
create or replace function nao_permite_valores_invalidos_exame() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') then
	
			if new.valor_exa < 50 then
			
				raise exception 'Valor de exame inválido! Verifique os valores padrões da clínica.';
				
			else
			
				return new;
				
			end if;

		end if;
								
	end;
	
$$language plpgsql;

create trigger valida_valor_exame before insert on exame for each row execute procedure nao_permite_valores_invalidos_exame();

-------------------------------------------------------------trigger CONSULTA------------------------------------------------------------------------------
create or replace function nao_permite_valores_invalidos_consulta() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') then
	
			if new.valor_con < 70 then
			
				raise exception 'Valor de consulta inválido!';
				
			else
			
				return new;
				
			end if;

		end if;
								
	end;
	
$$language plpgsql;


create trigger valida_valor_consulta before insert on consulta for each row execute procedure nao_permite_valores_invalidos_exame_consulta();

--drop trigger valida_valor_consulta on consulta
-----------------------------------------------------------------------------------------------------------------------------------------------
--- Função inserir item_compra sem compra

Create or replace function inserir_item_compra(int, int, int, int) returns void as $$
Declare
	valor_total float := 0;
	valor_unitario float := 0;
	codigo_medicamento int := 0;
	codigo_compra int := 0;


Begin

	select cod_med into codigo_medicamento from estoque where cod_est = $2;
	Select valor_med into valor_unitario from medicamento where cod_med = codigo_medicamento;
	valor_total = $3 * valor_unitario;
	

	IF  EXISTS (SELECT cod_com FROM compra WHERE cod_com = $1) then
		IF  EXISTS (SELECT cod_est FROM item_compra WHERE cod_com = $1 and cod_est = $2) then
			update item_compra set qtd_item = qtd_item + $3, valor_total_item = valor_total_item + valor_total where cod_com = $1 and cod_est = $2;
			

		ELSE
			insert into item_compra values ($1, $2, $3, valor_total);
			
		
		END IF;

		update compra set qtd_total_itens = qtd_total_itens + $3, valor_tot = valor_tot + valor_total where cod_com = $1;
		

	else
		insert into compra values (default, $4, $3, now(), valor_total);
		select max(cod_com) into codigo_compra from compra ;
		insert into item_compra values (codigo_compra, $2, $3, valor_total);
		
		
		
	end if;
	
	update estoque set qtd_med_est = qtd_med_est - $3 where cod_med = $2;
	raise info 'Cadastro concluido';
End;

$$ language 'plpgsql';



select inserir('item_compra', 3, 3, 8, 1);
select * from item_compra;
select * from compra;
select * from estoque;
select update_registro('item_compra', 'qtd_item', 10, 'qtd_item', 11);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

---- Trigger arrumar quantidade estoque/ item-pedido

create or replace function altera_quant_estoque() returns trigger as $$
declare 
	valor_new_maior int := 0;
	valor_old_maior int := 0;
	

begin

	valor_new_maior = new.qtd_item - old.qtd_item;
	valor_old_maior = old.qtd_item - new.qtd_item;

	if (TG_OP='INSERT') then
		update estoque set qtd_med_est = qtd_med_est - valor_old_maior where cod_est = new.cod_est;
	end if;

	if (TG_OP='UPDATE') then
            if new.qtd_item > old.qtd_item then
                update estoque set qtd_med_est = qtd_med_est - valor_old_maior where cod_est = new.cod_est;
            end if;

            if new.qtd_item < old.qtd_item then
                update estoque set qtd_med_est = qtd_med_est + valor_old_maior where cod_est = new.cod_est;
            end if;
	end if;
	
	return new;
end;
$$ language plpgsql;

---------------------------------------------------------------------------------------------------

create trigger gatilho01 before insert or update on item_compra for each row execute procedure funcao01();









select inserir('Veterinario', 'rukia', '1990-05-05', '64000-000', '99999-9999');
select inserir('Cliente', 'Naruto','1995-10-10', '64000-000', '99999-9999');
insert into cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) values ('Naruto','1995-10-10', '64000-000', '99999-9999')


--inserção em animal, exame, medicamento
select * from clinica
select inserir('Clinica', 'Leos pet', '64000-000', 50.00);
select inserir('Exame', 'raio-X', 20.00, 'fazer isso', null, null);
select inserir('Medicamento', 'nome_medicamento', 15.00, null, null, null);



---------------------------------------------------------------------------
select inserir('Animal', 'Akamaru', 560, 'cachorro', 3, 4, 'criança');
select inserir('Animal', 'Taurus', 709, 'cachorro', 35, 4, 'criança');

--teste1 Trigger crianca--
select inserir('Animal', 'lion', 1100, 'cachorro', 1, 5, 'criança');
--teste2 Trigger crianca--
select inserir('Animal', 'Safira', -1, 'cachorro', 1, 6, 'criança');
--teste3 Trigger jovem/adulto--
select inserir('Animal', 'Pandora', 60, 'cadela', 1, 6, 'jovem');

select * from animal

----------------------------------------------------------------------------


insert into cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) values ('Kairo','1995-10-10', '64000-000', '99999-9999') 
insert into cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) values ('Maria','1995-12-10', '64000-000', '8888-9999') 
insert into cliente (nome_cli, dt_nasc_cli, cep_cli, fone_cli) values ('João','1995-10-10', '64000-730', '99999-9999')


select * from cliente;

-------- teste do delete ---------
select nome_cli from cliente where nome_cli = 'Naruto';

----- funciona :) ------
DELETE FROM cliente WHERE nome_cli IN (select nome_cli from cliente where nome_cli = 'Naruto')

--- nao funciona :( ---
select delete_registro('cliente', 'nome_cli', 'Maria');