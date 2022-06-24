FROM confluentinc/cp-kafka-connect-base:6.2.4

RUN confluent-hub install --no-prompt debezium/debezium-connector-mysql:1.9.2.Final
RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:1.9.2.Final
RUN confluent-hub install --no-prompt confluentinc/kafka-connect-jdbc:10.5.0
RUN cd /usr/share/confluent-hub-components && \
    wget https://github.com/lensesio/stream-reactor/releases/download/3.0.1/kafka-connect-hive-3.0.1-2.5.0-all.tar.gz && \
    tar -xf kafka-connect-hive-3.0.1-2.5.0-all.tar.gz && \
    rm kafka-connect-hive-3.0.1-2.5.0-all.tar.gz

