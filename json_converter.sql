CREATE OR REPLACE FUNCTION convert_text_to_json()

  RETURNS event_trigger AS $$

DECLARE

  audit_query TEXT;

  r RECORD;

BEGIN

  IF tg_tag = 'CREATE TABLE' THEN

    r := pg_event_trigger_ddl_commands();
    -- INSERT INTO ddl_history (ddl_date, ddl_tag, object_name) VALUES (statement_timestamp(), tg_tag, r.object_identity);
    alter table r.object_identity alter column json_value type jsonb using json_value::jsonb;

  END IF;

END;

$$ LANGUAGE plpgsql;

CREATE EVENT TRIGGER json_converter_trigger ON ddl_command_end EXECUTE PROCEDURE convert_text_to_json();