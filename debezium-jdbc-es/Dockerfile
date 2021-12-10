FROM debezium/connect:1.7
ENV KAFKA_CONNECT_JDBC_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-jdbc \
    KAFKA_CONNECT_ES_DIR=$KAFKA_CONNECT_PLUGINS_DIR/kafka-connect-elasticsearch \
    KAFKA_CONNECT_POSTGRES_DIR=$KAFKA_CONNECT_PLUGINS_DIR/debezium-connector-postgres

ARG POSTGRES_VERSION=42.2.8
ARG KAFKA_JDBC_VERSION=5.3.2
ARG KAFKA_ELASTICSEARCH_VERSION=5.3.2

# Deploy PostgreSQL JDBC Driver
RUN cd /kafka/libs && curl -sO https://jdbc.postgresql.org/download/postgresql-$POSTGRES_VERSION.jar

# Deploy Kafka Connect JDBC
RUN mkdir $KAFKA_CONNECT_JDBC_DIR && cd $KAFKA_CONNECT_JDBC_DIR &&\
	curl -sO https://packages.confluent.io/maven/io/confluent/kafka-connect-jdbc/$KAFKA_JDBC_VERSION/kafka-connect-jdbc-$KAFKA_JDBC_VERSION.jar


RUN cd $KAFKA_CONNECT_POSTGRES_DIR &&\
	curl -sO https://repo1.maven.org/maven2/io/debezium/debezium-scripting/1.7.1.Final/debezium-scripting-1.7.1.Final.jar && \
    curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-jsr223/3.0.4/groovy-jsr223-3.0.4.jar &&\
    curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy/3.0.4/groovy-3.0.4.jar && \
    curl -sO https://repo1.maven.org/maven2/org/codehaus/groovy/groovy-json/3.0.4/groovy-json-3.0.4.jar