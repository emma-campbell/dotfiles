#!/bin/bash

if [ -e "$ZDOTDIR/functions/docker.sh" ]; then
  source "$ZDOTDIR/functions/docker.sh"
fi

alias dockerip="get_docker_ip"
