SHELL   = /bin/bash

.PHONY: config
config:
	apt update -y && apt install clickhouse-client -y
	rm -rf /db-data/clickhousedb-data/clickhouse01 /db-data/clickhousedb-data/clickhouse02 /db-data/clickhousedb-data/clickhouse03 /db-data/clickhousedb-data/clickhouse04
	mkdir -p /db-data/clickhousedb-data/clickhouse01/{config,dataDir} /db-data/clickhousedb-data/clickhouse02/{config,dataDir} /db-data/clickhousedb-data/clickhouse03/{config,dataDir} /db-data/clickhousedb-data/clickhouse04/{config,dataDir}
	rm -rf /db-data/clickhousedb-data/zookeeper01 /db-data/clickhousedb-data/zookeeper02 /db-data/clickhousedb-data/zookeeper03
	mkdir -p /db-data/clickhousedb-data/zookeeper01/{dataDir,dataLogDir,logs} /db-data/clickhousedb-data/zookeeper02/{dataDir,dataLogDir,logs} /db-data/clickhousedb-data/zookeeper03/{dataDir,dataLogDir,logs}
	REPLICA=01 SHARD=01 envsubst < config.xml > /db-data/clickhousedb-data/clickhouse01/config/config.xml
	REPLICA=02 SHARD=01 envsubst < config.xml > /db-data/clickhousedb-data/clickhouse02/config/config.xml
	REPLICA=03 SHARD=02 envsubst < config.xml > /db-data/clickhousedb-data/clickhouse03/config/config.xml
	REPLICA=04 SHARD=02 envsubst < config.xml > /db-data/clickhousedb-data/clickhouse04/config/config.xml
	cp users.xml /db-data/clickhousedb-data/clickhouse01/config/users.xml
	cp users.xml /db-data/clickhousedb-data/clickhouse02/config/users.xml
	cp users.xml /db-data/clickhousedb-data/clickhouse03/config/users.xml
	cp users.xml /db-data/clickhousedb-data/clickhouse04/config/users.xml

.PHONY: up
up:
	docker-compose up -d

.PHONY: start
start:
	docker-compose start

.PHONY: down
down:
	docker-compose down
