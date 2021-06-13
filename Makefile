init:
	pip install localstack
clouds:
	TMPDIR=$(shell pwd)/data docker-compose up
dynamodb-ui:
	npm i -g dynamodb-admin && DYNAMO_ENDPOINT=http://localhost:4566 dynamodb-admin