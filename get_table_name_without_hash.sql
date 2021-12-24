-- FUNCTION: public.get_table_name_without_hash_key(text, text)
-- DROP FUNCTION IF EXISTS public.get_table_name_without_hash_key(text, text);
CREATE OR REPLACE FUNCTION public.get_table_name_without_hash_key(table_name text, schema text) RETURNS text LANGUAGE 'plpgsql' COST 100 VOLATILE PARALLEL UNSAFE AS $BODY$
DECLARE tmp text;
tbl_wo_schema text;
BEGIN
select substring(
        $1
        from concat($2, '\.(.+)')
    ) into tbl_wo_schema;
select substring(
        tbl_wo_schema
        from '(.+)_([0-9])'
    ) into tmp;
if tmp is null then return tbl_wo_schema;
end if;
RETURN string_agg(tmp, ',');
END;
$BODY$;
ALTER FUNCTION public.get_table_name_without_hash_key(text, text) OWNER TO postgres;