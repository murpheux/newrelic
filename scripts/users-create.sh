#!/bin/bash

# Check if exactly 2 arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <arg1> <arg2>"
    exit 1
fi

# Assign arguments to variables
apiKey=$1
orgID=$2

# Read and csv file
while IFS=',' read -r name email tier
do
    echo $name $email $tier

    curl https://api.newrelic.com/graphql \
        -H 'Content-Type: application/json' \
        -H 'API-Key: '"$apiKey" \
        --data-binary '{"query":"mutation {\n  userManagementCreateUser(\n    createUserOptions: {\n      authenticationDomainId: \"'"$orgID"'\"\n      email: \"'"$email"'\"\n      name: \"'"$email"'\"\n      userType: '"$tier"'\n    }\n  ) {\n    createdUser {\n      id\n      email\n      name\n    }\n  }\n}", "variables":""}'

done < users.csv
