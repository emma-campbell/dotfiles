#!/bin/bash

# Add Homebrew Path
if [[ $(uname -m) == 'arm64' ]]; then
	export PATH=/opt/homebrew/bin:$PATH
else
	export PATH=/usr/local/opt:$PATH
fi


if [[ -e ~/.paths.local ]]; then
  source ~/.paths.local
fi
