CREATE UNIQUE INDEX equipe_pkey ON public.equipe USING btree (nome_fantasia);

CREATE UNIQUE INDEX funcionario_pkey ON public.funcionario USING btree (id);

CREATE INDEX idxcargo ON public.funcionario USING btree (cargo);

CREATE INDEX idxnomef ON public.funcionario USING btree (nome, idade, "salário", fk_equipe);

CREATE UNIQUE INDEX funcionarios_auditoria_pkey ON public.funcionarios_auditoria USING btree (cod);

CREATE INDEX idxpatrocinador ON public.patrocinador USING btree (patrocinador);

CREATE UNIQUE INDEX patrocinador_pkey ON public.patrocinador USING btree (id);

CREATE UNIQUE INDEX piloto_pkey ON public.piloto USING btree ("número");

CREATE UNIQUE INDEX "unidade_de_potência_pkey" ON public."unidade_de_potência" USING btree (fornecedor);
