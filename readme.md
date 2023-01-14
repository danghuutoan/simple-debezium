curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @sink.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @sink1.json
curl -i -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/ -d @source.json
curl -X DELETE -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/jdbc-sink
curl -X POST -H "Accept:application/json" -H  "Content-Type:application/json" http://localhost:8083/connectors/jdbc-sink/restart\?includeTasks=true
curl -X DELETE http://localhost:8081/subjects/test.inventory.orders-key
kafka-topics --bootstrap-server broker:29092 --delete --topic test.inventory.orders