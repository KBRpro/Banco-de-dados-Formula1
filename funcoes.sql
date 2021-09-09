CREATE OR REPLACE FUNCTION public.funcionario_audit()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$

Begin

         insert into funcionarios_auditoria (data, autor, alteracao) values (now(), user, TG_OP);

         return new;

end;

$function$
;

CREATE OR REPLACE FUNCTION public.gastototal(character varying)
 RETURNS integer
 LANGUAGE sql
AS $function$select sum(valor) from equipamento
where fk_equipe=$1;$function$
;

CREATE OR REPLACE FUNCTION public.idade_funcionario()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
    BEGIN
        -- Verificar se foi fornecido o nome e o salário do empregado
        IF NEW.idade<18 THEN
            RAISE EXCEPTION 'O empregado nao tem idade para trabalhar';
        END IF;
        RETURN NEW;
    END;
  $function$
;

CREATE OR REPLACE FUNCTION public.inserirfuncionario()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
id smallint;
nome varchar(60);
idade smallint;
salário int;
cargo varchar(30);
equipe varchar(20);
BEGIN
NEW.id=$1;
NEW.nome = $2;
NEW.idade = $3;
NEW.salario =$4;
NEW.cargo= $5;
NEW.equipe=$6;
RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.novo_patrocinador(patrocinador character varying, fk character varying)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
	DECLARE
	ID integer DEFAULT 0;
	
	begin
		select count(*) into ID from Patrocinador;
		insert into Patrocinador values (ID+1, patrocinador, fk);
	end;
$function$
;

CREATE OR REPLACE FUNCTION public."numeropeça"()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
declare
QuantidadePeça Integer;
begin
QuantidadePeça := (SELECT COUNT(*) Qtd from equipamento 
				   where equipamento.peça= new.peça and equipamento.fk_equipe=new.fk_equipe);
IF QuantidadePeça > 0 then
RAISE EXCEPTION 'A equipe já comprou esta peça';
END IF;
RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.numeropilotos()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
 declare
 	QuantidadePilotos Integer;
    begin
	    QuantidadePilotos := (SELECT COUNT (*) Qtd from piloto where FK_EQUIPE = new.fk_equipe);
        IF QuantidadePilotos > 2 then
            RAISE EXCEPTION 'A equipe já possui 2 pilotos';
        END IF;
        RETURN NEW;
    END;
  $function$
;

CREATE OR REPLACE FUNCTION public.numeropilotos2()
 RETURNS void
 LANGUAGE plpgsql
AS $function$
  DECLARE QuantidadePilotos INTEGER;
BEGIN

    QuantidadePilotos := (SELECT COUNT (*) Qtd from piloto where FK_EQUIPE = new.fk_equipe);

    IF QuantidadePilotos > 2 THEN
        RAISE EXCEPTION 'A equipe já possui 2 pilotos';
    END IF;

END $function$
;

CREATE OR REPLACE FUNCTION public.patrocinadoresequipe(character varying)
 RETURNS TABLE(patrocinador character varying)
 LANGUAGE plpgsql
AS $function$
    BEGIN
         RETURN QUERY
             SELECT patrocinador.patrocinador
             FROM patrocinador
             WHERE fk_equipe =$1;
    END;
$function$
;

CREATE OR REPLACE FUNCTION public.pilotosequipe(character varying)
 RETURNS TABLE(nome character varying, "vitórias" smallint, "pódios" smallint, "pontuação" smallint, fk_equipe2 character varying)
 LANGUAGE plpgsql
AS $function$
    BEGIN
         RETURN QUERY
             SELECT piloto.nome,piloto.vitórias,piloto.pódios,piloto.pontuação,piloto.fk_equipe
             FROM piloto
             WHERE fk_equipe =$1;
    END;
$function$
;
