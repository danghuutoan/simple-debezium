CREATE TABLE IF NOT EXISTS entity_attribute_group (
    entity_id VARCHAR(28) NOT NULL,
    attribute_group VARCHAR(28) NOT NULL,
    attribute_version INT NOT NULL,
    json_value jsonb NOT NULL,
    PRIMARY KEY (entity_id, attribute_group)
);
ALTER TABLE entity_attribute_group REPLICA IDENTITY FULL;
insert into entity_attribute_group (
        entity_id,
        attribute_group,
        attribute_version,
        json_value
    )
VALUES (
        'id_1',
        'group_1',
        1,
        ('{"key": "value"}')
    );
insert into entity_attribute_group (
        entity_id,
        attribute_group,
        attribute_version,
        json_value
    )
VALUES (
        ' id_2 ',
        ' group_2 ',
        1,
        ('{ "key": "value" }')
    );
CREATE DATABASE sink_db;