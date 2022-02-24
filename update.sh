curl -i -X PUT -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/inventory-connector-route-1/config -d '
{
    "connector.class": "io.debezium.connector.postgresql.PostgresConnector",
    "tasks.max": "1",
    "database.hostname": "citus",
    "database.port": "5432",
    "database.user": "postgres",
    "database.password": "password",
    "database.dbname": "postgres",
    "database.server.name": "sink_db",
    "schema.include.list": "public",
    "table.include.list": "public.entity_attribute_group,public.dbz_signal,public.entity_relation",
    "signal.data.collection": "public.dbz_signal",
    "database.history.kafka.bootstrap.servers": "kafka:9092",
    "key.converter": "io.confluent.connect.avro.AvroConverter",
    "value.converter": "io.confluent.connect.avro.AvroConverter",
    "key.converter.schema.registry.url": "http://schema-registry:8081",
    "value.converter.schema.registry.url": "http://schema-registry:8081",
    "topic.creation.default.replication.factor": 1,  
    "topic.creation.default.partitions": 10
}
'