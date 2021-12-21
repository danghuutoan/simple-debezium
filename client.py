from confluent_kafka.avro import AvroConsumer
from confluent_kafka.avro.serializer import SerializerError


c = AvroConsumer(
    {
        "bootstrap.servers": "kafka:9092",
        "group.id": "2",
        "schema.registry.url": "http://schema-registry:8081",
    }
)

c.subscribe(["sink_db.public.eag_group_1"])

while True:
    try:
        msg = c.poll(1)

    except SerializerError as e:
        print("Message deserialization failed for {}: {}".format(msg, e))
        break

    if msg is None:
        continue

    if msg.error():
        print("AvroConsumer error: {}".format(msg.error()))
        continue

    print(msg.value())

c.close()
