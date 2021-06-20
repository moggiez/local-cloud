# Local Cloud

Simulates AWS locally.

To create the whole stack run:

```bash
make universe
```

Check health:
Go to http://localhost:4566/health

## Tools to install

### `awslocal`

```bash
pip install awscli-local
```

### `jq`

- OS X

```bash
brew install jq
```

- Debian

```bash
sudo apt-get install jq
```

## Useful links

- LocalStack services health: http://localhost:4566/health
- AWS Lambda functions: http://localhost:4566/2015-03-31/functions/

## Calling Local AWS Gateway

(some handy scripts to get api id, stage, the url etc. exist in ./scripts and ./aws-helpers)

- Address of an api resource `http://localhost:4566/restapis/<api id>/<stage>/_user_request_/<path> Example: For `loadtest` resource:
  Get API id

```bash
awslocal apigateway get-rest-apis
```

Get Stages

```bash
awslocal apigateway get-stages --rest-api-id <api id>
```

Make the call

```bash
curl http://localhost:4566/restapis/yfwecjnz5o/blue/_user_request_/loadtest
```

## Prerequisites

- Python
- Docker
- npm

## How to run?

### Initialize it

```bash
make init
```

### Start localstack docker container

```bash
make clouds
```

## User interface

Localstack paid version provides UI, but we can have some UI for free.

### Dynamodb

Run the command below to have UI for DynamoDB:

```bash
make dynamodb-ui
```

### S3

Uncomment the `localstack-s3-ui` service in `docker-compose.yml` and restart localstack to get S3 UI (untested).

### Lambda

# Creating infrastructure locally

Run the command

```bash
make <project_name>
```

to create the infrastructure associated with a particular project

Example:

```bash
make storage
```
