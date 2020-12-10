#!/bin/bash 

service_display_name="[service:login:display_name]"
api_key="[credential:newrelic:personal_api_key]"
base_api_url="[app_config:newrelic:api_url]"

function log() {
	now=`date`
	echo "[$now] $1"
}

log "Starting..."

if [[ -z $1 ]]; then
	echo "Version string must be provided!"
	exit 1
elif [[ -z $2 ]]; then
	echo "Description string must be provided!"
	exit 1
fi

log "Searching for $service_display_name"
service_id=`curl -X GET "$base_api_url/v2/applications.json" -H "api-key:$api_key" -d "filter[name]=$service_display_name"|jq -r '.applications[0].id'`
log "Found service ID: $service_id"

options="{ \"deployment\": { \
\"revision\": \"$1\",\
\"description\": \"$2\",\
\"user\": \"alec@acmetelco.com\" }}"
			
log "Payload: $options"
result=`curl -X POST "$base_api_url/v2/applications/$service_id/deployments.json" -H "api-key:$api_key" -H "content-type: application/json" -d "$options"`
log "Result: $result"
log "Done."
