#!/bin/bash

namespace=$1

echo "==================================================================================="
echo "Removing evicted pods for namespace: \"${namespace}\""
echo "---------------------------------------------------"

for each in $(kubectl get pods -n ${namespace} | grep Evicted | awk '{print $1}'); do
	kubectl delete pods $each -n ${namespace}
done

echo "==================================================================================="
echo "\n"
