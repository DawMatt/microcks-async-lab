# Lab 01 - Simplified Default Microcks RabbitMQ Lab

## Overview

Steps the user through the lab described on the Microcks site: [RabbitMQ Mocking & Testing](https://microcks.io/documentation/guides/usage/async-protocols/rabbitmq-support/).

## Steps

1. Start Microcks, if not already started

`..\microcks-start.cmd` (Win) or
`..\microcks-start.sh` (Mac)

2. Open Microcks UI, ready to import an AsyncAPI: http://localhost:8080/#/importers

3. Use the `Upload` button to import the AsyncAPI found in this folder. `Choose file` to select the file, then `Upload` to register the API in Microcks.

4. Navigate to the [`API | Services`](http://localhost:8080/#/services) tab and confirm a new `Account Service` has been loaded.

5. Open up the service and view the different operations. Confirm that Mocks have been defined for each of the operations. Note the AMQP exchange that has been defined for the mocks.

6. Run `consumer.cmd` (Win) or `consumer.sh` (Mac) to start an AMQP consumer to listen to the mocked data. Messages based upon the mocks from the previous step should be the received by the consumer.