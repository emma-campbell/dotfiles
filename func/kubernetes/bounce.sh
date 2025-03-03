#!/bin/bash

function bounce() {
  namespace=$1
  api=$2
  env=$3

  echo "==================================================================================="
  echo "Bouncing \"${namespace}\" in \"${env}\""
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
  
  kubectl rollout restart "deployment/${api}" -n $namespace

  echo "==================================================================================="
  echo "\n"
}

