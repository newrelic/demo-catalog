#!/bin/bash 

base_api_url="[app_config:newrelic:api_url]"
api_key="[credential:newrelic:personal_api_key]"
host_display_name="[resource:authhost:display_name]"
base_infra_api_url="[app_config:newrelic:infra_collector_url]"
license_key="[credential:newrelic:license_key]"
nr_account_id="[credential:newrelic:account_id]"

nrql="SELECT entityGuid FROM SystemSample WHERE displayName='$host_display_name' LIMIT 1"
graphql_search="{ \"query\": \"{ actor { account(id: $nr_account_id)"
graphql_search+='{ nrql(query:\"'
graphql_search+="$nrql"
graphql_search+='\") { results }}}}" }'

function log() {
	now=`date`
	echo "[$now] $1"
}

log "Starting..."

if [[ -z $1 ]]; then
	echo "First argument must be 'connect' or 'disconnect'"
	exit 1
fi

log "Graphql string: $graphql_search"
graphql_result=`curl -X POST "$base_api_url/graphql" -H "api-key:$api_key" -H "Content-Type: application/json" -d "$graphql_search"`
log "Graphql result: $graphql_result"
host_guid=`echo "$graphql_result" | jq -r '.data.actor.account.nrql.results[0].entityGuid' | base64 --decode`
IFS='|' read -r -a guid_sections <<< "$host_guid"
host_id="${guid_sections[3]}" 
log "Host entity ID: $host_id"

payload_connect="[{ \"entityKeys\": [\"$host_display_name\"], \
\"entityId\": $host_id, \
\"source\": \"sessions/users\", \
\"IsAgent\": true, \
\"state\": { \
	\"alec\": { \
		\"id\": \"alec\" \
	} \
}}]"

payload_disconnect="[{ \"entityKeys\": [\"$host_display_name\"], \
\"entityId\": $host_id, \
\"source\": \"sessions/users\", \
\"IsAgent\": true, \
\"state\": { }}]"

if [[ $1 == "connect" ]]; then
	payload=$payload_connect
else
	payload=$payload_disconnect
fi

log "Payload: $payload"
result=`curl -X POST "$base_infra_api_url/inventory/state/bulk" -H "X-License-Key: $license_key" -H "User-Agent: New Relic Infrastructure Agent" -H "Content-Type: application/json" -d "$payload"`
log "Result: $result"
log "Done."
