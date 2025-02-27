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

    | Field         | Value                                             |
    | ---           | ---                                               |
    | Test Endpoint | amqp://microcks-rabbitmq:5672/t/signedup-exchange |
    | Operation     | SUBSCRIBE user/signedup                           |
    | Runner        | ASYNC API SCHEMA                                  |
    | Timeout       | Keep the default of 10 seconds                    |
    | Secret        | rabbitmq-local                                    |

8. Click `+Launch test!` to initiate the newly created test. After a few seconds this should display a test results page for the test. Click the `>` expanding arrow to display the individual test results, which should look similar to the following:

    ![Successful Test Result List](./TestSuccessful.png)

9. Terminate execution of the command initiated in step 5 (the `producer` script).

10. Run `producer-bad.cmd` (Win) or `producer-bad.sh` (Mac) to start an AMQP producer to publish events containing bad data to the `signedup-exchange` topic.

11. In the Microcks UI, click on the `Test History` breadcrumb at the top of the previous test run screen. Click the circular arrow icon to the far right of the most recent test (aka "Relaunch this test!").

    ![RelaunchThisTest](./RelaunchThisTest.png)

12. This will show the configuration details of the test created in step 7. Click `+Launch test!` to initiate the same test as before. After a few seconds this should display a test results page for the test. Click the `Full results` link and then the `>` expanding arrow to display the detailed test results, which should look similar to the following:

    ![Unsuccessful Test Result](./TestUnsuccessful.jpg)

## Key points

- Tests are run within the `microcks-async-minion` container, which was launched via `docker-compose`. As such the URL used in step 7 (defining the test) must be a valid URL within the `docker-compose` network. This is why we use a hostname of `localhost` within the `producer` script (which executes outside of `docker-compose`):

    `amqp://microcks:microcks@localhost:5672`

    and the hostname `microcks-rabbitmq` when creating the test:

    `amqp://microcks-rabbitmq:5672/t/signedup-exchange`

- The test URL includes an additional `/t` between the hostname part of the URL (`amqp://microcks-rabbitmq:5672`) and the exchange (`signedup-exchange`). This is a requirement of the testing functionality and indicates this exchange is a topic. Refer to the [Microcks documentation](https://microcks.io/documentation/guides/usage/async-protocols/rabbitmq-support/) to confirm the characters used for other exchange types.

- The test functionality requires basic authentication details to be specified via the `Secrets` feature used in step 6. Embedding basic authentication details within the test URL will not work.

- The exchange referred to by a test must exist before the test is launched. In this lab this means the `producer` or `producer-bad` script must be started before the corresponding test is launched, as these scripts automatically create the exchange as they start publishing to it.