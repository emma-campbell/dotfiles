#!/bin/bash

## Add java path
export JAVA_HOME=/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home
export PATH="$JAVA_HOME/bin:$PATH"

if [[ -e ~/.java.local ]]; then
  source ~/.java.local
fi
