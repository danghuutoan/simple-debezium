```
\copy companies from '/data/companies.csv' with csv
\copy campaigns from '/data/campaigns.csv' with csv
\copy ads from '/data/ads.csv' with csv
```

```
CREATE TABLE companies (
    id bigint NOT NULL,
    name text NOT NULL,
    image_url text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE campaigns (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    name text NOT NULL,
    cost_model text NOT NULL,
    state text NOT NULL,
    monthly_budget bigint,
    blacklisted_site_urls text[],
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);

CREATE TABLE ads (
    id bigint NOT NULL,
    company_id bigint NOT NULL,
    campaign_id bigint NOT NULL,
    name text NOT NULL,
    image_url text,
    target_url text,
    impressions_count bigint DEFAULT 0,
    clicks_count bigint DEFAULT 0,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);
```

```
ALTER TABLE companies ADD PRIMARY KEY (id);
ALTER TABLE campaigns ADD PRIMARY KEY (id, company_id);
ALTER TABLE ads ADD PRIMARY KEY (id, company_id);
```

```
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @sink.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @source.json
```

```
kafka-topics.sh --list --bootstrap-server kafka:9092
```


insert into entity_attribute_group (
    entity_id, attribute_group, attribute_version, json_value
)
select
    left(md5(i::text), 10),
    left(md5(random()::text), 28),
    i,
    '{"key": "value"}'
from generate_series(1, 1000000) s(i)


kafka-console-consumer.sh --bootstrap-server kafka:9092 --property print.key=true --from-beginning --topic sink_db.public.entity_attribute_group 


```
2022-05-11 14:21:52,277 ERROR  ||  WorkerSourceTask{id=abcdfdf-source-0} Task threw an uncaught and unrecoverable exception. Task is being killed and will not recover until manually restarted   [org.apache.kafka.connect.runtime.WorkerTask]

io.debezium.jdbc.JdbcConnectionException: ERROR: syntax error

at io.debezium.connector.postgresql.connection.PostgresReplicationConnection.initPublication(PostgresReplicationConnection.java:198)

at io.debezium.connector.postgresql.connection.PostgresReplicationConnection.createReplicationSlot(PostgresReplicationConnection.java:369)

at io.debezium.connector.postgresql.PostgresConnectorTask.start(PostgresConnectorTask.java:136)

at io.debezium.connector.common.BaseSourceTask.start(BaseSourceTask.java:130)

at org.apache.kafka.connect.runtime.WorkerSourceTask.initializeAndStart(WorkerSourceTask.java:225)

at org.apache.kafka.connect.runtime.WorkerTask.doRun(WorkerTask.java:186)

at org.apache.kafka.connect.runtime.WorkerTask.run(WorkerTask.java:243)

at java.base/java.util.concurrent.Executors$RunnableAdapter.call(Executors.java:515)

at java.base/java.util.concurrent.FutureTask.run(FutureTask.java:264)

at java.base/java.util.concurrent.ThreadPoolExecutor.runWorker(ThreadPoolExecutor.java:1128)

at java.base/java.util.concurrent.ThreadPoolExecutor$Worker.run(ThreadPoolExecutor.java:628)

at java.base/java.lang.Thread.run(Thread.java:829)

Caused by: org.postgresql.util.PSQLException: ERROR: syntax error

at org.postgresql.core.v3.QueryExecutorImpl.receiveErrorResponse(QueryExecutorImpl.java:2675)

at org.postgresql.core.v3.QueryExecutorImpl.processResults(QueryExecutorImpl.java:2365)

at org.postgresql.core.v3.QueryExecutorImpl.execute(QueryExecutorImpl.java:355)

at org.postgresql.jdbc.PgStatement.executeInternal(PgStatement.java:490)

at org.postgresql.jdbc.PgStatement.execute(PgStatement.java:408)

at org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:329)

at org.postgresql.jdbc.PgStatement.executeCachedSql(PgStatement.java:315)

at org.postgresql.jdbc.PgStatement.executeWithFlags(PgStatement.java:291)

at org.postgresql.jdbc.PgStatement.executeQuery(PgStatement.java:243)

at io.debezium.connector.postgresql.connection.PostgresReplicationConnection.initPublication(PostgresReplicationConnection.java:152)

... 11 more
```