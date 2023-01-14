export SOURCE="localhost:9092"
export TARGET="localhost:9093"
export KAFKA_HOME="/Users/toan/workspace/study/algorithms-on-string/kafka_2.13-3.2.3"

$KAFKA_HOME/bin/kafka-topics.sh --bootstrap-server $SOURCE --create --topic my-topic --config 'retention.ms=10000,cleanup.policy=compact'
echo "finish"
$KAFKA_HOME/bin/kafka-console-consumer.sh --bootstrap-server $SOURCE --group my-group --topic my-topic
echo "finish"
for i in $(seq 1 100); do echo $i; done | $KAFKA_HOME/bin/kafka-console-producer.sh --bootstrap-server $SOURCE --topic my-topic
# wait until the retention policy deletes the records and then start mm2
$KAFKA_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $TARGET --describe --group my-group
$KAFKA_HOME/bin/kafka-consumer-groups.sh --bootstrap-server $SOURCE --describe --group my-group