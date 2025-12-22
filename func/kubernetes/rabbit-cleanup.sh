#!/bin/bash

source "$(dirname "$0")/bounce.sh"

function cleanup_rabbit() {
  env=$1
  namespace="${2:-application}"

  bounce repository $env $namespace
  bounce activity $env $namespace
  bounce connect $env $namespace
  bounce exporter $env $namespace
  bounce fhir $env $namespace
  bounce identity $env $namespace
  bounce ingestor $env $namespace
  bounce notification $env $namespace
  bounce research $env $namespace
  bounce search $env $namespace
  bounce storage $env $namespace
}
