#!/bin/bash

# Check if exactly 2 arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <arg1> <arg2>"
    exit 1
fi

# Assign arguments to variables
acctId=$1
apiKey=$2

data=$(cat ~/Workspace/newrelic/nerdgraph/query/basic.gql)

condata='{"query":'"${data}"', "variables":""}'
echo $condata

echo $(tr '\n' '\\n' < ~/Workspace/newrelic/nerdgraph/query/basic.gql)

#curl https://api.newrelic.com/graphql -H 'Content-Type: application/json' -H 'API-Key: '"$apiKey" --data-binary $condata
