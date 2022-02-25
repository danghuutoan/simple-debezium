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

move shards out of master node
citus_drain_node(node_name, nodeport)

excute on worker
SELECT * from citus_add_node('worker-101', 5432);
SELECT * from citus_add_node('worker-101', 5432);

verify
SELECT * FROM citus_get_active_worker_nodes();