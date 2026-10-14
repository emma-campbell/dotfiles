#!/bin/bash

# I keep running into a `ENETUNREACH` error
# when trying to use anything having to do with
# NPM on node 18. According to stack overflow,
# using ipv4 instead of ipv6 should resolve this.
# export NODE_OPTIONS="--dns-result-order=ipv4first"

if [[ -e ~/.node.local ]]; then
  source ~/.node.local
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
