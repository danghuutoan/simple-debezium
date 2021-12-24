-- FUNCTION: public.log_ddl()

-- DROP FUNCTION IF EXISTS public.log_ddl();

CREATE OR REPLACE FUNCTION public.log_ddl()
    RETURNS event_trigger
    LANGUAGE 'plpgsql'
    COST 100
    VOLATILE NOT LEAKPROOF
AS $BODY$
DECLARE audit_query TEXT;
r RECORD;
create_citus_table text;
BEGIN 
IF tg_tag = 'CREATE TABLE' THEN 
    FOR r IN SELECT * FROM pg_event_trigger_ddl_commands() LOOP 
        RAISE NOTICE 'table % %', r.object_identity, r.command_tag;
        if r.command_tag = 'CREATE TABLE' then
            if get_table_name_without_hash_key(r.object_identity, 'public') = r.object_identity then
                if left(r.object_identity, 11) in ('public.eag_', 'public."eag') then
                BEGIN
                perform master_get_table_metadata(get_table_name_without_hash_key(r.object_identity, 'public'));
                RAISE NOTICE 'table is distributed already';
                EXCEPTION WHEN OTHERS THEN
                    RAISE NOTICE 'table is not distributed ';
                    create_citus_table = get_table_name_without_hash_key(r.object_identity, 'public');
                END;
                end if;
            else
                BEGIN
                perform master_get_table_metadata(get_table_name_without_hash_key(r.object_identity, 'public'));
                RAISE NOTICE 'table is distributed already';
                EXCEPTION WHEN OTHERS THEN
                    RAISE NOTICE 'table is not distributed ';
                    create_citus_table = r.object_identity;
                END;
            end if;

        end if;
        if r.command_tag = 'CREATE INDEX' then
            if create_citus_table is not null then
            RAISE NOTICE ' create distributed table for %', create_citus_table;
            PERFORM create_distributed_table(create_citus_table, 'entity_id');
            end if;
        end if;
    END LOOP;
END IF;
END;
$BODY$;

ALTER FUNCTION public.log_ddl()
    OWNER TO postgres;
