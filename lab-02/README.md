# Lab 02 - Simplified AsyncAPI Tests Microcks RabbitMQ Lab

## Overview

Steps the user through the Run AsyncAPI component (step 4) of the lab described on the Microcks site: [RabbitMQ Mocking & Testing](https://microcks.io/documentation/guides/usage/async-protocols/rabbitmq-support/).

## Steps

**Note**: Steps 1 to 3 can be skipped if Lab 01 has already been performed.

1. Start Microcks, if not already started

    `..\microcks-start.cmd` (Win) or<br/>
    `..\microcks-start.sh` (Mac)

2. Open Microcks UI, ready to import an AsyncAPI: http://localhost:8080/#/importers

3. Use the `Upload` button to import the AsyncAPI found in the `lab-01` folder. `Choose file` to select the file, then `Upload` to register the API in Microcks.

4. Navigate to the [`API | Services`](http://localhost:8080/#/services) page and confirm a new `Account Service` has been loaded.

5. Run `producer.cmd` (Win) or `producer.sh` (Mac) to start an AMQP producer to publish events containing valid data to the `signedup-exchange` topic.

6. Navigate to the [`Administration`](http://localhost:8080/#/admin) page and the `Secrets` tab within it. Create a new secret with the following details, clicking the `Create` button once all details are entered:

    | Field               | Value                 |
    | ---                 | ---                   |
    | Name                | rabbitmq-local        |
    | Description         | Local RabbitMQ Broker |
    | Authentication Type | Basic Authentication  |
    | Username            | microcks              |
    | Password            | microcks              |

7. Navigate back to the [`API | Services`](http://localhost:8080/#/services) page and click on `Account Service`, then click the `+New Test` button. In the test page supply the following details:

    | Field         | Value                                     |
    | ---           | ---                                       |
    | Test Endpoint | amqp://localhost:5672/t/signedup-exchange |
    | Operation     | SUBSCRIBE user/signedup                   |
    | Runner        | ASYNC API SCHEMA                          |
    | Timeout       | Keep the default of 10 seconds            |
    | Secret        | rabbitmq-local                            |

8. Click `+Launch test!` to initiate the newly created test. After a few seconds this should display a test results page for the test.
