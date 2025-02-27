# Test: requires secret (basic auth, microcks:microcks)
# Test URL: amqp://microcks-rabbitmq:5672/t/signedup-exchange
node ../api-tooling/async-clients/amqpjs-client/producer-file.js amqp://microcks:microcks@localhost:5672 signedup-exchange topic signup-bad.json
