CREATE TABLE ddl_history (
    id serial primary key,
    ddl_date timestamptz,
    ddl_tag text,
    object_name text,
    command_tag text,
    in_extension boolean
)