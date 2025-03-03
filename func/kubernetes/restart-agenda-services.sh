#!/bin/bash

function restart_services() {
    env=$1

    echo "Restarting ${env} environment"
    echo "---------------------------------------------------"

    if [ "$env" = "prod" ]; then
      echo "Using production context"
      kubectl config use-context arn:aws:eks:us-east-1:236731023323:cluster/eksProd > /dev/null
    elif [ "$env" = "dev" ]; then
        echo "Using development context"
        kubectl config use-context arn:aws:eks:us-east-1:851409790737:cluster/eksTest > /dev/null
    else;
        echo "Invalid environment context"
        exit 0
    fi

    input_list=("repository-api", "activity-api" "authorization-api" "connect-api" "engagement-api" "enrollment-api" "exporter-api" "fhir-api" "identity-api" "ingestor-api" "notification-api" "2:processor-api" "research-api" "search-api" "storage-api")

    for item in input_list; do
        bounce item item env
    done

    echo "All services restarted"
}