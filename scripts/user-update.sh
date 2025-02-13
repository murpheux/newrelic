#!/bin/bash

# Check if exactly 2 arguments are provided
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <arg1> <arg2>"
    exit 1
fi

# Assign arguments to variables
apiKey=$1
orgID=$2

# Read and parse JSON array
json_array=$(curl https://api.newrelic.com/graphql -H 'Content-Type: application/json' -H 'API-Key: '"$apiKey" --data-binary '{"query":"{\n  actor {\n    organization {\n      userManagement {\n        authenticationDomains(id: \"'"$orgID"'\") {\n          authenticationDomains {\n            users {\n              users {\n                id\n                name\n                email\n                lastActive\n                type {\n                  displayName\n                  id\n                }\n              }\n            }\n          }\n        }\n      }\n    }\n  }\n}", "variables":""}' | jq '.data.actor.organization.userManagement.authenticationDomains.authenticationDomains.[0].users.users' | jq '[.[] | {id, email}]' | jq -c '.[]')


# Loop through each element of the array
for item in $json_array; do
  # Extract values using jq
  id=$(echo $item | jq -r '.id')
  email=$(echo $item | jq -r '.email')
  
  # Process each item (e.g., print the values)
  if [ $(echo $email | awk -F'@' '{print $2}') == 'sharefile.com' ]; then
      newemail=$(echo $email | sed 's/gmail/yahoo/') # change to yahoo.com

      data='{"query":"mutation {\n  userManagementUpdateUser(\n    updateUserOptions: { id: \"'"$id"'\", email: \"'"$newemail"'\" }\n  ) {\n    user {\n      id\n      email\n    }\n  }\n}", "variables":""}'
      curl https://api.newrelic.com/graphql -H 'Content-Type: application/json' -H 'API-Key: '"$apiKey" --data-binary "$data"

  fi 

done
