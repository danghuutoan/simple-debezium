FROM debezium/connect:1.9
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc \
    KAFKA_CONNECT_ES_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-elasticsearch \
    KAFKA_CONNECT_POSTGRES_DIR=$KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-postgres

ARG POSTGRES_VERSION=42.2.24
ARG KAFKA_JDBC_VERSION=10.2.5
ARG KAFKA_ELASTICSEARCH_VERSION=5.3.2
USER root:root
RUN microdnf update -y && microdnf install -y wget
# Deploy PostgreSQL JDBC Driver
# RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar
# Deploy Kafka Connect JDBC
# RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
# 	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar && \
#     curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar && \
#     curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-jsr223/3.0.4/groovy-jsr223-3.0.4.jar &&\
#     curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy/3.0.4/groovy-3.0.4.jar && \
    # curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-json/3.0.4/groovy-json-3.0.4.jar

# COPY ./ExtractNewRecordState.jar $KAFKA_CONNECT_JDBC_DIR/ExtractNewRecordState.jar

RUN cd $KAFKA_CONNECT_PLUGINS_DIR && \
    curl -sO https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-jdbc/versions/10.4.1/confluentinc-kafka-connect-jdbc-10.4.1.zip && \
    unzip -o confluentinc-kafka-connect-jdbc-10.4.1.zip && \
    rm confluentinc-kafka-connect-jdbc-10.4.1.zip


# RUN cd $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-mysql && \
#     wget https://github.com/danghuutoan/debezium-timestamp-converter/releases/download/v1.0.1/DebeziumAllTimestampFieldsToAvroTimestampConverter-1.0.1.jar
COPY  ./DebeziumAllTimestampFieldsToAvroTimestampConverter-1.0.2.jar $KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-mysql/DebeziumAllTimestampFieldsToAvroTimestampConverter-1.0.2.jar
# RUN cd $KAFKA_CONNECT_POSTGRES_DIR &&\
# 	curl -sO https://repo1.maven.org/maven2/io/debezium/debezium-scripting/1.7.1.Final/debezium-scripting-1.7.1.Final.jar && \
#     curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-jsr223/3.0.4/groovy-jsr223-3.0.4.jar &&\
#     curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy/3.0.4/groovy-3.0.4.jar && \
#     curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-json/3.0.4/groovy-json-3.0.4.jar

ARG JMX_AGENT_VERSION=0.9
RUN mkdir -p /kafka/etc && cd /kafka/etc &&\
        curl -so jmx_prometheus_javaagent.jar \
        https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/$JMX_AGENT_VERSION/jmx_prometheus_javaagent-$JMX_AGENT_VERSION.jar

COPY config.yml /kafka/etc/config.yml

RUN rm -rf /kafka/connect/debezium-connector-vitess && rm -rf /kafka/connect/debezium-connector-db2 && rm -rf kafka/connect/debezium-connector-sqlserver \
&& rm -rf /kafka/connect/debezium-connector-mongodb && rm -rf rm -rf /kafka/connect/debezium-connector-oracle
USER kafka