# Microcks AsyncAPI Lab

## Overview

[Microcks](https://microcks.io/)  is:

> The open source, cloud native tool for API Mocking and Testing
>
> Microcks leverages API standards to provide a uniform and multi-protocol approach, empowering your API and microservices lifecycle. It strengthens your ecosystem to create an adaptable API value chain #APIDevOps


This repository pre-configures a lightweight [Microcks](https://microcks.io/) environment supporting AsyncAPIs, including the RabbitMQ, Kafka (via Red Panda), and Websockets protocols. 

The user can then step through various test labs to see the Microcks environment in action.

## Labs

| Lab | Purpose |
| --- | --- |
| 01 | Simplified version of the default Microcks RabbitMQ lab |

**Note**: All labs below assume the setup steps below have been completed and the environment has successfully started.

## Setup

Please install the following if not already installed on your system:

- [Node.js LTS](https://nodejs.org/en)
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)

The remaining pre-requisites for the labs are installed via scripts within the `setup` folder.

| Script | Purpose |
| --- | --- |
| setupamqpjs.cmd | Setup an AMQP client that can be used for producing and consuming messages via AMQP. |
| setupasyncapicli.cmd | Setup the AsyncAPI CLI used for editing and validating AsyncAPI specifications. |

## Environment

Our Microcks environment depends upon [Docker Compose](https://docs.docker.com/compose/) and is started using:

`microcks-start.cmd`

and stopped using:

`microcks-start.cmd`

The environment and configuration are based upon those in the [Microcks Repository](https://github.com/microcks/microcks/tree/master/install/docker-compose). The Docker Compose files themselves contain only cosmetic modifications. 

The environment configuration exists within the `config` folder, and has been modified as follows:

- `application.properties` - AMQP protocol bindings were enabled and the local RabbitMQ instance configured
- `features.properties` - AMQP setup as the default binding and AMQP endpoint configured to the local RabbitMQ instance
