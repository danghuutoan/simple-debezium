CREATE OR REPLACE FUNCTION log_ddl() RETURNS event_trigger AS $$
DECLARE audit_query TEXT;
r RECORD;
BEGIN IF tg_tag = 'CREATE TABLE' THEN FOR r IN
SELECT *
FROM pg_event_trigger_ddl_commands() LOOP if r.command_tag = 'CREATE TABLE' then
INSERT INTO ddl_history (ddl_date, ddl_tag, object_name, command_tag)
VALUES (
        statement_timestamp(),
        tg_tag,
        r.object_identity,
        r.command_tag
    );
end if;
END LOOP;
END IF;
END;
$$ LANGUAGE plpgsql;
CREATE EVENT TRIGGER log_ddl_info ON ddl_command_end EXECUTE PROCEDURE log_ddl();