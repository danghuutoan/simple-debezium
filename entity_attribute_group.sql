CREATE TABLE IF NOT EXISTS entity_attribute_group (
    entity_id VARCHAR(28) NOT NULL,
    attribute_group VARCHAR(28) NOT NULL,
    attribute_version INT NOT NULL default 1,
    json_value jsonb NOT NULL,
    created timestamp default CURRENT_TIMESTAMP,
    PRIMARY KEY (entity_id, attribute_group)
);
ALTER TABLE entity_attribute_group REPLICA IDENTITY FULL;

insert into entity_attribute_group (
    entity_id, attribute_group, attribute_version, json_value
)
select
    left(md5(i::text), 10),
    left(md5(random()::text), 28),
    i,
    '{"key": "value"}'
from generate_series(1, 10000) s(i);


CREATE TABLE IF NOT EXISTS entity_relation (
    entity_id VARCHAR(28) NOT NULL,
    attribute_group VARCHAR(28) NOT NULL,
    attribute_version INT NOT NULL default 1,
    json_value jsonb NOT NULL,
    created timestamp default CURRENT_TIMESTAMP,
    PRIMARY KEY (entity_id, attribute_group)
);
ALTER TABLE entity_relation REPLICA IDENTITY FULL;

insert into entity_relation (
    entity_id, attribute_group, attribute_version, json_value
)
select
    left(md5(i::text), 10),
    left(md5(random()::text), 28),
    i,
    '{"key": "value"}'
from generate_series(1, 10000) s(i);

CREATE TABLE public.dbz_signal (id varchar(64), type varchar(32), data varchar(2048));
CREATE DATABASE sink_db;