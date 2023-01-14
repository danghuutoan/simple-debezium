export SOURCE="localhost:9092"
export TARGET="localhost:9093"
export KAFKA_HOME="/Users/toan/workspace/study/algorithms-on-string/kafka_2.13-3.2.3"

for i in $(seq 1 100); do echo $i; done | $KAFKA_HOME/bin/kafka-console-producer.sh --bootstrap-server $SOURCE --topic my-topic
# wait until the retention policy deletes the records and then start mm2
# $KAFKA_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $TARGET --describe --group my-group
$KAFKA_HOME/bin/kafka-console-producer.sh --topic test --bootstrap-server $SOURCE --property parse.key=true  --property key.separator=":"
$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server $SOURCE --create --topic test \
    --partitions 1 --replication-factor 1 \
    --config cleanup.policy=compact \
    --config min.cleanable.dirty.ratio=0.001 \
    --config segment.ms=5000 \
    --config delete.retention.ms=5000