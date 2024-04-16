-- Active: 1712670173221@@127.0.0.1@5432@20241_fatec_ipi_pbdi_cursores
-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

DO $$
DECLARE
--1. declaração do cursor
cur_rank_youtubers CURSOR (v_video_count INT, v_category_1 VARCHAR, v_category_2 VARCHAR)
    FOR SELECT youtuber, rank FROM tb_youtubers WHERE video_count >= v_video_count AND (category = v_category_1 OR category = v_category_2);
    v_youtuber VARCHAR(200);
    v_video_count INT := 1000;
    v_category_1 VARCHAR(200) := 'Sports';
    v_category_2 VARCHAR(200) := 'Music';
    tupla RECORD;
BEGIN
--2. abertura do cursor
    OPEN cur_rank_youtubers(v_video_count := v_video_count, v_category_1 := v_category_1, v_category_2 := v_category_2);
    LOOP
    --3. Recuperação dos dados de interesse
    FETCH cur_rank_youtubers INTO tupla;
    EXIT WHEN NOT FOUND;
    RAISE NOTICE '%', tupla;
    END LOOP;
--4. Fechamento do cursor
CLOSE cur_rank_youtubers;
END;
$$

-- 1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal
-- - O SELECT deverá ordenar em ordem não reversa
-- - O Cursor deverá ser movido para a última tupla
-- - Os dados deverão ser exibidos de baixo para cima

DO $$
DECLARE
    cur_nomes_youtubers REFCURSOR;
    v_youtuber VARCHAR(200);
BEGIN
    OPEN cur_nomes_youtubers FOR
        SELECT youtuber
        FROM tb_youtubers;
    
    FETCH LAST FROM cur_nomes_youtubers INTO v_youtuber;    
    WHILE FOUND LOOP
        RAISE NOTICE '%', v_youtuber;
        FETCH PRIOR FROM cur_nomes_youtubers INTO v_youtuber;
    END LOOP;
    CLOSE cur_nomes_youtubers;
END;
$$
