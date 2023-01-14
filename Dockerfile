FROM debezium/connect:2.0.1.Final

ENV MAVEN_DEP_DESTINATION=$KAFKA_HOME/libs \
    CONFLUENT_VERSION=7.3.1 \
    AVRO_VERSION=1.11.1 \
    APICURIO_VERSION=2.1.5.Final \
    GUAVA_VERSION=31.0.1-jre
# RUN  cd /kafka/connect && curl https://d1i4a15mxbxib1.cloudfront.net/api/plugins/confluentinc/kafka-connect-avro-converter/versions/7.3.0/confluentinc-kafka-connect-avro-converter-7.3.0.zip -o confluentinc-kafka-connect-avro-converter-7.3.0.zip &&\
#         unzip confluentinc-kafka-connect-avro-converter-7.3.0.zip

COPY ./confluentinc-kafka-connect-jdbc-10.6.3.zip /kafka/connect/confluentinc-kafka-connect-jdbc-10.6.3.zip
RUN  cd /kafka/connect && unzip confluentinc-kafka-connect-jdbc-10.6.3.zip && rm confluentinc-kafka-connect-jdbc-10.6.3.zip
# RUN docker-maven-download confluent kafka-connect-avro-converter "$CONFLUENT_VERSION" b6f3b7e63dca16e327f6f9a7e9b1d9aa && \
#     docker-maven-download confluent kafka-connect-avro-data "$CONFLUENT_VERSION" bd14fd74cdc0b39ba804cc8b46215759 && \
#     docker-maven-download confluent kafka-avro-serializer "$CONFLUENT_VERSION" ac384251e11d31045f0c48be539e60ae && \
#     docker-maven-download confluent kafka-schema-serializer "$CONFLUENT_VERSION" 7b57801bfeef3bb7179b34793ce3d208 && \
#     docker-maven-download confluent kafka-schema-registry-client "$CONFLUENT_VERSION" 44948bfe61ce00679e7ba1a3287fff3d && \
# RUN    docker-maven-download confluent monitoring-interceptors "$CONFLUENT_VERSION" 0d8140c1392cdfb4715ab3a7490e0e55 && \
#     docker-maven-download confluent common-config "$CONFLUENT_VERSION" e9ba5dc8c78fc0c169776d895ac3868d && \
#     docker-maven-download confluent common-utils "$CONFLUENT_VERSION" 6b80623df81001b0c35ecaa8057d87a2 && \
#     docker-maven-download central org/apache/avro avro "$AVRO_VERSION" 9fad4fb0e34810ae5f3d7cb5223a7e1c && \
#     docker-maven-download central org/apache/kafka kafka-clients 3.3.1 989cbfe5c4adcc81966a682bdb306925 && \
#     docker-maven-download central org/apache/kafka connect-api 3.3.1 253881e579567240141d6daf04cbc3f6 && \
#     # docker-maven-download apicurio "$APICURIO_VERSION" bd7adf3f599968db4529fe4592d07bc8 && \
RUN    docker-maven-download central com/google/guava guava "$GUAVA_VERSION" bb811ca86cba6506cca5d415cd5559a7 &&\
    docker-maven-download confluent monitoring-interceptors "$CONFLUENT_VERSION" 0d8140c1392cdfb4715ab3a7490e0e55

USER root
RUN chmod -R +x /kafka/connect
USER kafka