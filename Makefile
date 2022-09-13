.PHONY: config
config:
	apt update -y && apt install clickhouse-client -y
	rm -rf /clickhousedb-data/clickhouse01 /clickhousedb-data/clickhouse02 /clickhousedb-data/clickhouse03 /clickhousedb-data/clickhouse04
	mkdir -p /clickhousedb-data/clickhouse01 /clickhousedb-data/clickhouse02 /clickhousedb-data/clickhouse03 /clickhousedb-data/clickhouse04
	REPLICA=01 SHARD=01 envsubst < config.xml > /clickhousedb-data/clickhouse01/config.xml
	REPLICA=02 SHARD=01 envsubst < config.xml > /clickhousedb-data/clickhouse02/config.xml
	REPLICA=03 SHARD=02 envsubst < config.xml > /clickhousedb-data/clickhouse03/config.xml
	REPLICA=04 SHARD=02 envsubst < config.xml > /clickhousedb-data/clickhouse04/config.xml
	cp users.xml /clickhousedb-data/clickhouse01/users.xml
	cp users.xml /clickhousedb-data/clickhouse02/users.xml
	cp users.xml /clickhousedb-data/clickhouse03/users.xml
	cp users.xml /clickhousedb-data/clickhouse04/users.xml

.PHONY: up
up:
	docker-compose up -d

.PHONY: start
start:
	docker-compose start

.PHONY: down
down:
	docker-compose down
