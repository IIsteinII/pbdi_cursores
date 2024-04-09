-- cursor vinculado(bound)
-- exibir nomes dos canais, concatenando a seu numero de inscritos

-- um bloquinho anônimo
DO $$
DECLARE
	--cursor bound (vinculado)
	-- 1. Declaração (ainda não está aberto)
	cur_nomes_e_inscritos CURSOR FOR
		SELECT youtuber, subscribers
		FROM tb_youtubers;
		tupla RECORD;
		--tupla.youtuber devolve o youtuber
		--tupla.subscribers devolve o número de subscribers
		resultado TEXT DEFAULT '';
BEGIN
	-- 2. Abertura do cursor
	OPEN cur_nomes_e_inscritos;
	-- vamos usar um loop while
	-- 3. Recuperação dos dados
	FETCH cur_nomes_e_inscritos INTO tupla;
	WHILE FOUND LOOP
		-- concatenacao, operador ||
		resultado := resultado || tupla.youtuber || ': ' || tupla.subscribers || ', ';
		FETCH cur_nomes_e_inscritos INTO tupla;
	END LOOP;
	-- 4. Fechamento
	CLOSE cur_nomes_e_inscritos;
	RAISE NOTICE '%', resultado;
END;
$$

-- cursor não vinculado com query dinânimca, ou seja, 
-- uma query representada como uma string

-- -- um bloquinho anônimo
-- DO $$
-- DECLARE
-- 	-- 1. Declaração
-- 	cur_nomes_a_partir_de REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- 	v_ano INT := 2008;
-- 	v_nome_tabela VARCHAR(200) := 'tb_youtubers';
-- BEGIN
-- 	-- 2. Abertura
-- 	OPEN cur_nomes_a_partir_de FOR EXECUTE
-- 	format(
-- 	'
-- 		SELECT
-- 			youtuber
-- 		FROM %s
-- 		WHERE started >= $1
-- 	', v_nome_tabela
-- 	)USING v_ano;
-- 	-- 3. Recuperação dos dados
-- 	LOOP
-- 		FETCH cur_nomes_a_partir_de INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechamento cursor
-- 	CLOSE cur_nomes_a_partir_de;
-- END;
-- $$

-- cursor não vinculado (unbound)

-- -- um bloquinho anônimo
-- DO $$
-- DECLARE
-- 	-- 1. Declaração do cursor (cursor não vinculado (unbound))
-- 	cur_nomes_youtubers REFCURSOR;
-- 	v_youtuber VARCHAR(200);
-- BEGIN
-- 	-- 2. Abertura do cursor
-- 	OPEN cur_nomes_youtubers FOR
-- 		SELECT youtuber FROM tb_youtubers;
		
-- 	-- 3. Recuperação de dados de interesse
-- 	LOOP
-- 		FETCH cur_nomes_youtubers INTO v_youtuber;
-- 		EXIT WHEN NOT FOUND;
-- 		RAISE NOTICE '%', v_youtuber;
-- 	END LOOP;
-- 	-- 4. Fechar o cursor
-- 	CLOSE cur_nomes_youtubers;
-- END;
-- $$

-- criação das tabelas

-- CREATE TABLE tb_youtubers(
-- 	cod_top_youtubers SERIAL PRIMARY KEY,
-- 	rank INT,
-- 	youtuber VARCHAR(200),
-- 	subscribers INT,
-- 	video_views VARCHAR(200),
-- 	video_count INT,
-- 	category VARCHAR(200),
-- 	started INT
-- );

-- SELECT * FROM tb_youtubers;

-- ALTER TABLE tb_youtubers 
-- ALTER COLUMN video_views 
-- TYPE BIGINT USING (video_views::BIGINT);

