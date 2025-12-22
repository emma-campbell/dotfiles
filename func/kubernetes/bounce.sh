#!/bin/bash

function bounce() {
  api=$1
  env=$2
  namespace="${3:-application}"

  echo "==================================================================================="
  echo "Bouncing \"${api}-api\" in \"${env}\""
  echo "---------------------------------------------------"

  if [ "$env" = "prod" ]; then
      echo "Using production context"
      kubectl config use-context hugo-prod > /dev/null
  elif [ "$env" = "dev" ]; then
      echo "Using development context"
      kubectl config use-context hugo-dev > /dev/null
  elif [ "$env" = "qa" ]; then
      echo "Using qa context"
      kubectl config use-context hugo-qa > /dev/null
  else;
      echo "Invalid environment context"
      exit 0
  fi
  
  kubectl rollout restart "deployment/${api}-api" -n $namespace

  echo "==================================================================================="
  echo "\n"
}

