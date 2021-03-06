
Docker-compose.yml that allows you to start a fully orchestred business automation platform with a single command.

Requeriments: docker 1.19+, docker-compose 1.26+ (1.28.0+ for using profiles).

# Services

## Business-Central (jBPM)

Allows you to create BPMN/DMN based projects. It also provides a controller to deploy them to a connected kie-server. Once deployed, you can make use of jBPM forms to manage user tasks.

**How to access**
http://localhost:8081/business-central/kie-wb.jsp?locale=en_EN

    User: jbpmAdmin
    Password: password@1

## H2 database
Database with persistent storage, useful for kie-server and process-instance-migration services.

**How to access**
http://localhost:8082/login.jsp (using web browser)\
jBPM runtime schema, jBPM EJB timers schema and jBPM process instance migration schema datasources configurations are pre-loaded by default. 

## Kie-server (jBPM)
Allows you to create and engine (or cluster of a number of engines by defining more than one copy of the service) to deploy and execute BPMN/DMN kjars. kie system properties are configurable by modifying "EXTRA_OPTS" env variable in docker-compose.yml file.
By default, this service relies on H2 database service for both runtime and EJB timers. Elasticsearch events are sent by default to elasticsearch service. It also has event-driven capabilities through BPMN messages/signals using kafka service (see https://docs.jboss.org/jbpm/release/latestFinal/jbpm-docs/html_single/#message-receive-event-proc_kie-apis and https://docs.jboss.org/jbpm/release/latestFinal/jbpm-docs/html_single/#message-send-event-proc_kie-apis)

**How to access**
http://localhost:8080/kie-server/docs/

    User: jbpmAdmin
    Password: password@1

## Mockserver
Allows to create mock services by creating a file called expectations.json in the same directory where docker-compose.yml is located with the expected format (see https://www.mock-server.com/mock_server/initializing_expectations.html)

## Castlemock
Allows to mock both REST HTTP & SOAP services (see https://castlemock.github.io/)

**How to access**
http://localhost:1082/castlemock/

    User: admin
    Password: admin

**How to access**
http://localhost:1080/<your-created-mock-service>

## Process-instance-migration (jBPM)
Allows you to migrate process instances from a specific version to a newer one through a web app with an easy-to-use UI. It needs to be connected to a kie-server and it needs h2 database service to be up and running.

**How to access**
http://localhost:8090/

    User: jbpmAdmin
    Password: password@1

## XES exporter (jBPM)
Allows you to get event logs from a specific processId in XES format for further process mining tasks.

**How to access**
http://localhost:8089/services/rest/jbpm-xes-exporter/process-model/{processId}

## Kafka
Kafka service that supports Event-driven services

## Kafdrop
Allows to monitor messages in topics with kafdrop UI

**How to access**
http://localhost:9000

## Elasticsearch
It supports jBPM elasticsearch event emmiter by storing events fired in kie-server processes and tasks executions with two default indices: "processes" and "tasks".

**How to access**
http://localhost:9200/processes/_search
http://localhost:9200/tasks/_search


## Kibana
Allows you to build dashboards from Elasticsearch indices.

**How to access**
http://localhost:5601/app/home#/

## Appromore
Process mining application that allows you to load XES event logs files retrieved from jBPM (and other vendors) and analyze performance and variants of the process from its logs.
Requires a "fake" registration to be able to log in, just with user and password as important fields.

**How to access**
http://localhost:8084/login.zul


## Appromore-database
Supports appromore application. No need to access it directly.
\



# Profiles
Although you can combine services the way you want, a set of default profiles are provided (docker-compose 1.28.0 or later is required. Otherwise, just comment services you don't want to start and exec "docker-compose up"):

**Starts the full stack (kie-server single node)** Requires over 14GB of free RAM

    docker-compose --profile all up
\
**Starts the full stack (kie-server 2-node cluster)** Requires over 16GB of free RAM

    docker-compose --profile all --profile runtime-cluster up
\
**Starts designer only**

    docker-compose --profile designer up
\
**Starts the runtime stack (designer, kie-server single node, h2 database)**

    docker-compose --profile runtime up
\
**Starts the runtime stack (designer, kie-server 2-node cluster, h2 database)**

    docker-compose --profile runtime-cluster up
\
**Starts the process-instance-migration stack (designer, kie-server single node, h2 database, process-instance-migration)**

    docker-compose --profile process-instance-migration up
\
**Starts the process-monitoring stack (elasticsearch, kibana)**

    docker-compose --profile process-monitoring up
\
**Starts the runtime stack (designer, kie-server single node, h2 database) + elasticsearch events**

    docker-compose --profile runtime-with-events up
 \
**Starts the process-monitoring stack (elasticsearch, kibana) + runtime stack**

    docker-compose --profile runtime --profile process-monitoring up
 \
**Starts the process-mining stack (Apromore, xes-exporter)**

    docker-compose --profile runtime --profile process-mining up

