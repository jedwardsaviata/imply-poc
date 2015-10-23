This is a Proof of Concept for running imply in a distributed Docker environment.

It is split into three parts, each with its own docker-compose.yml file:
- Services
  - Zookeeper (cluster coordination)
  - PostgreSQL (metadata)
  - Cassandra (deep storage)
- Druid
  - Master (Coordinator and Overlord nodes)
  - Data (Historical and Middle Manager nodes)
  - Query (Broker node and the Bard service)
- Panoramix
  - Panoramix server

There are a few scripts which assist in launching the system:
- run.sh : launches (creates or restarts) the entire POC cluster
- halt.sh : stops all docker containers in the POC cluster
- remove.sh : removes (deletes) all docker containers in the POC cluster

