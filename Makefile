init:
	pip install localstack
universe: clouds hosted-zone storage api
clean-data:
	rm -rf ./data/localstack && mkdir -p ./data/localstack && rm -rf temp && mkdir temp
clouds:
	TMPDIR=$(shell pwd)/data docker-compose up -d
status:
	curl http://localhost:4566/health
stop:
	docker-compose down
clear-sky: stop clean-data
dynamodb-ui:
	npm i -g dynamodb-admin && DYNAMO_ENDPOINT=http://localhost:4566 dynamodb-admin
hosted-zone:
	cd infrastructure/route53 && terraform init && terraform apply -auto-approve
storage:
	./scripts/run_infra_locally.sh storage
api:
	./scripts/run_infra_locally.sh api
npm-auth:
	aws codeartifact login --tool npm --repository team-npm --domain moggies-io --domain-owner 989665778089

.PHONY: clouds