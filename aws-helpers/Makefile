API_ID=$(shell awslocal apigateway get-rest-apis | jq '.items[0].id')
get-api-id:
	echo ${API_ID}
get-stage-names:
	awslocal apigateway get-stages --rest-api-id ${API_ID} | jq '.item[].stageName'
get-api-resources:
	awslocal apigateway get-resources --rest-api-id ${API_ID}
get-tables:
	awslocal dynamodb list-tables
get-functions:
	awslocal lambda list-functions
get-playbooks:
	curl http://localhost:4566/restapis/${API_ID}/blue/_user_request_/playbook/${ORG_ID} --data '{}' -H "Authorization: ${COGNITO_TOKEN}"