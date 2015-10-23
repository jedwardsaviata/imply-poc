FROM aviata/imply-base

COPY common.runtime.properties /imply/imply-${IMPLY_VERSION}/conf/druid/_common/common.runtime.properties

EXPOSE 8080 8081 8082 8083 8084 8085 8090 9095
# 8080 - Druid Port
# 8081 - Druid Coordinator
# 8082 - Druid Broker
# 8083 - Druid Historical
# 8084 - Druid Overlord
# 8085 - Druid Middle Manager
# 8090 - Druid Indexing Service
# 9095 - Bard Service

# No RUN command defined as this will be separated as needed
