-- Database: "AnL_Clinica_Veterinaria"

-- DROP DATABASE "AnL_Clinica_Veterinaria";

CREATE DATABASE "AnL_Clinica_Veterinaria"
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'Portuguese_Brazil.1252'
       LC_CTYPE = 'Portuguese_Brazil.1252'
       CONNECTION LIMIT = -1;


create table cliente(
cod_cli serial primary key,
nome_cli varchar(30) not null,
dt_nasc_cli date not null,
cep_cli varchar(9) not null,
fone_cli varchar(12) not null
);


--drop table cliente cascade
select * from cliente

select inserir_geral('cliente', 'default, ''Marta'', ''1998-06-2'', ''64005-000'', ''3225-5119''');
select inserir_geral('cliente', 'default, ''Roberto'', ''1999-03-10'', ''64000-000'', ''3214-5555''');

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
select * from idade

select inserir_geral('animal', 'default, ''Lion'', 15, ''cachorro'', 6, 2, ''adulto''');
select inserir_geral('animal', 'default, ''Sultão'', 450, ''cachorro'', 20, 1, ''criança''');


create table idade (
cod_ani int not null references animal (cod_ani),
nome_ani varchar(30),
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
select inserir_geral('veterinario', 'default, ''Francisco'', ''1989-08-19'', ''64007-230'', ''3215-7777''');
select inserir_geral('veterinario', 'default, ''Fernando'', ''1989-02-13'', ''64017-230'', ''3215-8888''');

--drop table veterinario cascade

create table exame(
cod_exa serial primary key,
nome_exa varchar(30) not null,
valor_exa float not null
);

--drop table exame cascade
select * from exame
select inserir_geral('exame', 'default, ''Raio-X'', 120.00');
select inserir_geral('exame', 'default, ''Ultrassonografia'', 200.00');
select inserir_geral('exame', 'default, ''Sangue'', 50');


create table funcionario (
cod_fun serial primary key,
nome_fun varchar(30) not null,
dt_nasc_fun date not null,
fone_fun varchar(12) not null,
cep_fun varchar(9) not null
);

select inserir_geral('funcionario', 'default, ''Josiel'', ''1990-01-24'', ''9884-7121'', ''64000-230''');
select * from funcionario
--drop table funcionario cascade

create table medicamento(
cod_med serial primary key,
nome_med varchar(30) not null,
valor_med float not null
);

select inserir_geral('medicamento', 'default, ''maxCan'', 23.50');
select inserir_geral('medicamento', 'default, ''Dipirona'', 3.5');
select * from medicamento
--drop table medicamento cascade

create table clinica(
cod_clin serial primary key,
nome_clin varchar(30) not null,
cep_clin varchar(9) not null,
valor_clin float not null
);
select inserir_geral('clinica', 'default, ''PetMania Sul'', ''64000-000'', 75.00');
select inserir_geral('clinica', 'default, ''PetMania Norte'', ''64000-000'', 75.00');
select inserir_geral('clinica', 'default, ''PetMania Leste'', ''64000-000'', 75.00');


select * from clinica

--drop table clinica cascade

create table vet_clinica(
cod_vet_clin serial primary key,
cod_clin int not null references clinica (cod_clin),
cod_vet int not null references veterinario (cod_vet),
dt_ent date not null,
dt_sai date
);

select * from vet_clinica

select * from veterinario

select * from clinica


select inserir_geral('vet_clinica', 'default, 1, 1, ''2018-06-29'', null');
select inserir_geral('vet_clinica', 'default, 3, 2, ''2017-02-11'', null');
--drop table vet_clinica cascade


create table fun_clinica(
cod_fun_clin serial primary key,
cod_clin int  not null references clinica (cod_clin),
cod_fun int  not null references funcionario (cod_fun),
dt_ent date not null,
dt_sai date
);

select inserir_geral('fun_clinica', 'default, 2, 1, ''2018-03-12'', null');
select inserir_geral('fun_clinica', 'default, 1, 2, ''2018-03-12'', null');

select * from fun_clinica

select * from clinica

drop table fun_clinica cascade

create table estoque(
cod_est serial primary key,
cod_clin int not null references clinica (cod_clin),
cod_med int not null references medicamento (cod_med),
qtd_med_est int not null
);

select inserir_geral('estoque', 'default, 3, 1, 120');
select inserir_geral('estoque', 'default, 3, 2, 1');
select inserir_geral('estoque', 'default, 2, 1, 170');
select inserir_geral('estoque', 'default, 2, 2, 10');
select inserir_geral('estoque', 'default, 1, 2, 120');

select * from estoque

insert into estoque values (default, 2, 2, 10)

select * from medicamento

drop table estoque cascade

create table consulta(
cod_con serial primary key,
cod_ani int not null references animal (cod_ani),
cod_fun_clin int not null references fun_clinica (cod_fun_clin),
cod_vet_clin int not null references vet_clinica (cod_vet_clin),
descr_con varchar(150) not null,
sint_con varchar(50) not null,
diag_con varchar(50) not null,
valor_con float not null,
dt_hr timestamp
);

drop table consulta cascade
select inserir_geral('consulta', 'default, 1, 3, 1, ''nao sei'', ''dores'', ''muitas dores'', 71');
select inserir_geral('consulta', 'default, 2, 3, 2, ''nao sei'', ''dores'', ''muitas dores'', 90');

select * from animal

select * from fun_clinica

select * from vet_clinica

create table realiza_exame(
cod_rea_exa serial primary key,
cod_con int not null references consulta (cod_con),
cod_exa int not null references exame (cod_exa),
valor_rea_exa float not null
);

select * from consulta

select * from realiza_exame

--drop table realiza_exame cascade
select inserir_geral('realiza_exame', 'default, 4, 1, 80.0');
select inserir_geral('realiza_exame', 'default, 3, 1, 80.0');



create table compra(
cod_com int primary key,
cod_con int not null references consulta (cod_con),
qtd_total_itens int not null,
dt_com timestamp not null,
valor_tot float not null
);


create table item_compra(
cod_com int not null references compra (cod_com),
cod_est int not null references estoque (cod_est),
qtd_item int not null,
valor_total_item float not null
);

select * from compra
select * from item_compra
select * from consulta
select * from estoque

select inserir_item_compra(2, 4, 1, 3);
select inserir_item_compra(1, 3, 155, 2);
select inserir_item_compra(1, 3, 2, 2);

select inserir_item_compra(2, 1, 2, 6);
select inserir_item_compra(2, 3, 2, 6);

select inserir_geral('compra', '1, 4, 0, now(), 0.0');
select inserir_geral('compra', '2, 6, 0, now(), 0.0');

delete from item_compra
delete from compra
delete from estoque


update estoque set qtd_med_est = 7 where cod_est=1

select * from medicamento
select * from consulta
select * from medicamento
select * from estoque


drop table item_compra cascade

select * from compra;

select * from item_compra;

select * from estoque;

drop table item_compra cascade;
drop table compra cascade;

delete
from estoque
where cod_est = 2



----------------------------------------------------------------------------------INSERT---------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION inserir_geral(TEXT, TEXT) RETURNS void AS $$

DECLARE
  query TEXT;

	Begin
	  query := 'insert into  ' || $1 || ' values (' || $2 || ' );';

	  EXECUTE query;
	  RAISE INFO 'Todos os registros foram inseridos';
	End

$$ LANGUAGE 'plpgsql';

--drop function inserir_geral(text, text);
-------------------------------------------------------------------------------------INSERIR ITEM_COMPRA---------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION inserir_geral(TEXT, TEXT, TEXT, TEXT, TEXT) RETURNS void AS $$

DECLARE
  query TEXT;

	Begin
	  select inserir_item_compra($2, $3, $4, $5);
	End

$$ LANGUAGE 'plpgsql';

--drop function inserir_geral(text, text, text, text, text);

--------------------------------------------------------------------------------- DELETE -------------------------------------------------------------------------------------------


CREATE OR REPLACE FUNCTION delete_registro(tabela TEXT, coluna TEXT, valor TEXT) RETURNS void AS $$

DECLARE
  query TEXT;

	Begin
	  query := 'DELETE FROM ' || $1 || ' WHERE ' || $2 || ' = ''' || $3 || ''';';

	  EXECUTE query;
	  RAISE INFO 'Todos os registros realacionados foram deletados';
	End

$$ LANGUAGE 'plpgsql';

---------------------------------------------------------------------------------UPDATE -------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION update_registro(TEXT, TEXT, TEXT, TEXT, TEXT) RETURNS void AS $$

DECLARE
  query TEXT;

	Begin
	  query := 'update  ' || $1 || ' set ' || $2 || ' = ''' || $3 || '''  where ' || $4 || ' = ''' || $5 || ''' ;';

	  EXECUTE query;
	  RAISE INFO 'Todos os registros realacionados foram atualizados';
	End

$$ LANGUAGE 'plpgsql';


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

$$ language plpgsql;

create trigger valida_peso_animal before insert on animal for each row execute procedure validando_peso();


------------------------------------------------------------------------------------------TRIGGER CLIENTE--------------------------------------------------------------

/*
create table cliente(
cod_cli serial primary key,
nome_cli varchar(30) not null,
dt_nasc_cli date not null,
cep_cli varchar(9) not null,
fone_cli varchar(12) not null
);
*/

create or replace function checando_valores_cliente() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.nome_cli is null or new.dt_nasc_cli is null or new.cep_cli is null or new.fone_cli is null then
			
				raise exception 'Valores nulos não são aceitos: verifique todos os campos passados.';

			else

				return new;

			end if;

		end if;

	end;

$$ language plpgsql;

create trigger gatilho_checando_valores_cliente before insert or update on cliente for each row execute procedure checando_valores_cliente();


------------------------------------------------------------------------------- TRIGGER IDADE --------------------------------------------------------------------------

create or replace function definindo_idade_em_dia_mes_ano() returns trigger as $$

	begin

		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then


			if new.classific_ani ilike 'criança' then

				insert into idade values (new.cod_ani, new.nome_ani, new.idade_ani, null, null);

			elsif new.classific_ani ilike 'jovem' then

				insert into idade values (new.cod_ani, new.nome_ani, null, new.idade_ani, null);

			elsif new.classific_ani ilike 'adulto' then

				insert into idade values (new.cod_ani, new.nome_ani, null, null, new.idade_ani);

			else
				raise exception 'Teste';

			end if;

			return new;
		end if;

	end;

$$ language plpgsql;

create trigger gatilho_idade_em_d_m_a after insert or update on animal for each row execute procedure definindo_idade_em_dia_mes_ano();


------------------------------------------------------------------------------------------TRIGGER EXAME--------------------------------------------------------------

create or replace function valores_invalidos_exame() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.valor_exa < 50 then

				raise exception 'Valor de exame inválido! Verifique os valores padrões da clínica.';

			else

				return new;

			end if;

		end if;

	end;

$$ language plpgsql;

create trigger valida_valor_exame before insert or update on exame for each row execute procedure valores_invalidos_exame();


------------------------------------------------------------------------------------TRIGGER CONSULTA------------------------------------------------------------------------------

create or replace function nao_permite_valores_invalidos_consulta() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.valor_con < 70 then

				raise exception 'Valor de consulta inválido!';

			else

				return new;

			end if;

		end if;

	end;

$$ language plpgsql;

create trigger valida_valor_consulta before insert or update on consulta for each row execute procedure nao_permite_valores_invalidos_consulta();


----------------------------------------------------------------------- TRIGGER VALOR MEDICAMENTO ---------------------------------------------------------------------------

create or replace function valida_valor_medicamento() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.valor_med > 0 and new.valor_med <= 200.00 then

				return new;

			else

				raise exception 'Confira se o valor passado para o medicamento está correto.';

			end if;

		end if;

	end;

$$ language plpgsql;

create trigger validando_valor_medic before insert or update on medicamento for each row execute procedure valida_valor_medicamento();


----------------------------------------------------------------------TRIGGERS VALOR DA CLINICA (consulta)-----------------------------------------------------------------

create or replace function valida_valor_consulta_da_clin() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.valor_clin < 70 then

				raise exception 'Valor da consulta da clínica inválido!';

			else

				return new;

			end if;

		end if;

	end;

$$ language plpgsql;


create trigger valida_valor_clinica before insert or update on clinica for each row execute procedure valida_valor_consulta_da_clin();


--------------------------------------------------------------------------------- TRIGGER ESTOQUE ----------------------------------------------------------------------------

create or replace function validacoes_estoque() returns trigger as $$

	begin

		if (TG_OP = 'UPDATE') then

			if (old.qtd_med_est - new.qtd_med_est) <= 10 then

				raise info 'Aviso: estoque em quantidade mínima!(%)',(old.qtd_med_est - new.qtd_med_est);

			end if;

		end if;

		if (TG_OP = 'INSERT') then

			if new.qtd_med_est < 20 then

				raise exception 'A quantidade mínima para armazenamento em estoque é 20 unidades';

			end if;

		end if;
		
	return new;
	end;

$$ language plpgsql;

create trigger valida_estoque after insert or update on estoque for each row execute procedure validacoes_estoque();

--drop trigger valida_estoque on estoque
------------------------------------------------------------------------------------------TRIGGER REALIZA EXAME--------------------------------------------------------------

create or replace function nao_aceita_valor_invalido_realiza_exame() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.valor_rea_exa < 50 then

				raise exception 'Valor inválido! Verifique os valores padrões da clínica.';

			else

				return new;
	
			end if;

		end if;

	end;

$$ language plpgsql;

create trigger valida_realiza_exame before insert or update on realiza_exame for each row execute procedure nao_aceita_valor_invalido_realiza_exame();


----------------------------------------------------------------------TRIGGER valida entradas item_compra sem compra -----------------------------------------------------

create or replace function valida_entrada_item_compra_estoque() returns trigger as $$

	begin

		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.cod_com <= 0 or new.cod_com is null then

				raise exception 'Código de compra fornecido não é válido.';

			end if;

			if new.cod_est <= 0 or new.cod_est is null then

				raise exception 'Código de estoque fornecido é inválido.';

			end if;

			if new.qtd_item <= 0 or new.qtd_item is null then

				raise exception 'Verifique se o valor da quantidade está correto.';

			end if;

			return new;

		end if;

	end;

$$ language plpgsql;

create trigger gatilho_item_compra before insert or update on item_compra for each row execute procedure valida_entrada_item_compra_estoque();
--drop trigger gatilho_item_compra on item_compra
------------------------------------------------------------------------------- TRIGGER COMPRA --------------------------------------------------------------------------------

create or replace function valida_entrada_compra() returns trigger as $$
	begin
		if (TG_OP = 'INSERT') or (TG_OP = 'UPDATE') then

			if new.cod_con <= 0 or new.cod_con is null then

				raise exception 'Código de consulta inválido.';

			end if;

			if new.qtd_total_itens <= 0 or new.qtd_total_itens is null then

				raise exception 'Valor da quantidade total de itens é inválido.';

			end if;

			return new;

		end if;

	end;
$$ language plpgsql;

create trigger valida_fields_compra before insert or update on compra for each row execute procedure valida_entrada_compra();

--drop trigger valida_fields_compra on compra;


------------------------------------------------------------------ Função inserir item_compra sem compra -------------------------------------------------------------------


Create or replace function inserir_item_compra(cod_compra int, cod_estoque int, qtd int, cod_consulta int) returns void as $$

Declare
valor_total float := 0;
valor_unitario float := 0;
codigo_medicamento int := 0;

	Begin

		  Select cod_med into codigo_medicamento from estoque where cod_est = $2;
		  Select valor_med into valor_unitario from medicamento where cod_med = codigo_medicamento;

		  if codigo_medicamento is null then
		  
			raise exception 'Estoque não existe ou medicamento não existe';

		  end if;

		  IF NOT EXISTS(SELECT cod_con FROM consulta WHERE cod_con = $4) then
		  
			RAISE EXCEPTION 'CONSULTA NAO EXISTE.';
			
		  END IF;


		  if valor_unitario is null then
		  
			raise exception 'Medicamento não existe';

		  else
		  
			valor_total = $3 * valor_unitario;

		  end if;


		IF EXISTS(SELECT cod_com FROM compra WHERE cod_com = $1) then
		
			IF EXISTS(SELECT cod_est FROM item_compra WHERE cod_com = $1 and cod_est = $2) then
			
				update item_compra set qtd_item = qtd_item + $3, valor_total_item = valor_total_item + valor_total where cod_com = $1 and cod_est = $2;

			ELSE

				insert into item_compra values ($1, $2, $3, valor_total);

			END IF;

			update compra set qtd_total_itens = qtd_total_itens + $3, valor_tot = valor_tot + valor_total where cod_com = $1;

		ELSE

			insert into compra values ($1, $4, $3, now(), valor_total);
			
			insert into item_compra values ($1, $2, $3, valor_total);
			
		END IF;

		--raise info 'passou %d', $3;
		raise info 'Item cadastrado.';
	End;

$$ language 'plpgsql';


-------------------------------------------------------------------- Trigger arrumar quantidade estoque/ item-compra -----------------------------------------------------------

create or replace function altera_quant_estoque() returns trigger as $$

declare
  qtd_est int := 0;
  new_qtd_item int := 0;

	begin
		IF (TG_OP = 'UPDATE') then
			IF EXISTS(select cod_est from item_compra) then
				new_qtd_item := new.qtd_item - old.qtd_item;
			END IF;
		END IF;

		select qtd_med_est into qtd_est from estoque where cod_est = new.cod_est;

		if qtd_est >= new.qtd_item and new_qtd_item = 0 then
		
			update estoque set qtd_med_est = qtd_med_est - new.qtd_item where cod_est = new.cod_est;
			raise info 'Entrou na primeira condicao.';
			
		elsif qtd_est >= new_qtd_item then
		
			update estoque set qtd_med_est = qtd_med_est - new_qtd_item where cod_est = new.cod_est;
			raise info 'Entrou na segunda condicao.';
			
		else
			raise exception 'Erro, nao ha estoque suficiente';
		end if;
		return new;
	end;

$$ language plpgsql;

create trigger gatilho_altera_quant_estoque after insert or update on item_compra for each row execute procedure altera_quant_estoque();

drop trigger gatilho_altera_quant_estoque on item_compra

---------------------------------------------------------------------Triggers, não permite valores idênticos para todas as tabelas --------------------------------------------------------------------------

create or replace function nao_permite_duplicidade_cliente() returns trigger as $$

	begin

		  if (TG_OP = 'INSERT') then

			if exists(select * from cliente where nome_cli = new.nome_cli and dt_nasc_cli = new.dt_nasc_cli and cep_cli = new.cep_cli and fone_cli = new.fone_cli) then
	
				raise exception 'cliente já existe';

			end if;

		  end if;

	return new;
	end;
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_cliente before insert or update on cliente for each row execute procedure nao_permite_duplicidade_cliente();

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

create or replace function nao_permite_duplicidade_animal() returns trigger as $$


	begin
		if (TG_OP = 'INSERT') then
	  
			if exists(select * from animal where nome_ani = new.nome_ani and peso_ani = new.peso_ani and descr_ani = new.descr_ani and idade_ani = new.idade_ani and cod_cli = new.cod_cli and classific_ani = new.classific_ani) then
		
				raise exception 'animal já existe';

			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_animal before insert or update on animal for each row execute procedure nao_permite_duplicidade_animal();

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_idade() returns trigger as $$
declare

	begin

		if (TG_OP = 'INSERT') then 
		
			if exists(select * from idade where cod_ani = new.cod_ani and nome_ani = new.nome_ani and dia_ani = new.dia_ani and mes_ani = new.mes_ani and ano_ani = new.ano_ani) then
		
				raise exception 'idade já existe';

			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_idade before insert or update on idade for each row execute procedure nao_permite_duplicidade_idade();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_veterinario() returns trigger as $$


	begin
		if (TG_OP = 'INSERT') then
		
			if exists(select * from veterinario where nome_vet = new.nome_vet and dt_nasc_vet = new.dt_nasc_vet and cep_vet = new.cep_vet and fone_vet = new.fone_vet) then
	
				raise exception 'veterinario já existe';

			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_veterinario before insert or update on veterinario for each row execute procedure nao_permite_duplicidade_veterinario();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_exame() returns trigger as $$ 

	begin
		if (TG_OP = 'INSERT') then
			if exists(select * from exame where nome_exa = new.nome_exa and valor_exa = new.valor_exa) then
				raise exception 'exame já existe';
			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_exame before insert or update on exame for each row execute procedure nao_permite_duplicidade_exame();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_funcionario() returns trigger as $$


	begin

		if (TG_OP = 'INSERT') then

			if exists(select * from funcionario where nome_fun = new.nome_fun and dt_nasc_fun = new.dt_nasc_fun and cep_fun = new.cep_fun and fone_fun = new.fone_fun) then
	
				raise exception 'funcionario já existe';

			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_funcionario before insert or update on funcionario for each row execute procedure nao_permite_duplicidade_funcionario();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_medicamento() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') then
		
			if exists(select * from medicamento where nome_med = new.nome_med and valor_med = new.valor_med) then
			
				raise exception 'medicamento já existe';
				
			end if;
		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_medicamento before insert or update on medicamento for each row execute procedure nao_permite_duplicidade_medicamento();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_clinica() returns trigger as $$

	begin
		if (TG_OP = 'INSERT') then
		
			if exists(select * from clinica where nome_clin = new.nome_clin and valor_clin = new.valor_clin and cep_clin = new.cep_clin) then
	
				raise exception 'clinica já existe';
			end if;

		end if;

	 return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_clinica before insert or update on clinica for each row execute procedure nao_permite_duplicidade_clinica();

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_vet_clinica() returns trigger as $$


	begin

		if (TG_OP = 'INSERT') then
			if exists(select * from vet_clinica where cod_vet = new.cod_vet and cod_clin = new.cod_clin and dt_ent = new.dt_ent and dt_sai = new.dt_sai) then
				raise exception 'vet_clinica já existe';
			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_vet_clinica before insert or update on vet_clinica for each row execute procedure nao_permite_duplicidade_vet_clinica();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_fun_clinica() returns trigger as $$


	begin

		if (TG_OP = 'INSERT') then
			if exists(select * from fun_clinica where cod_fun = new.cod_fun and cod_clin = new.cod_clin and dt_ent = new.dt_ent and dt_sai = new.dt_sai) then
				raise exception 'fun_clinica já existe';
			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_fun_clinica before insert or update on fun_clinica for each row execute procedure nao_permite_duplicidade_fun_clinica();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_estoque() returns trigger as $$


	begin
		if (TG_OP = 'INSERT') then
			if exists(select * from estoque where cod_clin = new.cod_clin and cod_med = new.cod_med and qtd_med_est = new.qtd_med_est) then
				raise exception 'estoque já existe';
			end if;

		end if;

	return new;
	end;
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_estoque before insert or update on estoque for each row execute procedure nao_permite_duplicidade_estoque();


--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


create or replace function nao_permite_duplicidade_consulta() returns trigger as $$


	begin

		if (TG_OP = 'INSERT') then 
		
			if exists(select * from consulta where cod_ani = new.cod_ani and cod_fun_clin = new.cod_fun_clin and cod_vet_clin = new.cod_vet_clin and descr_con = new.descr_con and sint_con = new.sint_con and diag_con = new.diag_con and valor_con = new.valor_con and dt_hr = new.dt_hr) then
	
				raise exception 'consulta já existe';
				
			end if;

		end if;

	return new;
	end;
	
$$ language plpgsql;

create trigger gatilho_nao_permite_duplicidade_consulta before insert or update on consulta for each row execute procedure nao_permite_duplicidade_consulta();


----------------------------------------------------------Não permitir o mesmo medicamento na mesma clinica ----------------------------------------------------------------------------------------------------------------------
/*

create or replace function atualizacao_medicamento_existente() returns trigger as
$$
declare

begin

  if (TG_OP = 'INSERT') then
    if exists(select *
              from estoque
              where cod_clin = new.cod_clin
                and cod_med = new.cod_med)
                then
      update estoque set qtd_med_est = qtd_med_est + new.qtd_med_est where cod_clin = new.cod_clin and cod_med = new.cod_med;
    end if;

  end if;

  return new;
end;
$$ language plpgsql;

create trigger gatilho_atualizacao_medicamento_existente
  before insert or update
  on estoque
  for each row
execute procedure atualizacao_medicamento_existente();
*/