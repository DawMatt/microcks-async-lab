# Test: requires secret (basic auth, user: microcks, password: microcks)
# Test URL: amqp://localhost:5672/t/signedup-exchange
node ../api-tooling/async-clients/amqpjs-client/producer.js amqp://microcks:microcks@localhost:5672 signedup-exchange topic
