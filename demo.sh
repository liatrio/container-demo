#!/bin/bash

########################
# include the magic
########################
. demo-magic.sh

# hide the evidence
clear

# Demo Magic Commands Summary:
# pe "command" - Print and Execute: Simulates typing the command, waits for ENTER, then executes it.
# pei "command" - Print and Execute Immediately: Simulates typing the command, then executes it immediately.
# p "command" - Print Only: Simulates typing the command, waits for ENTER, but does not execute it.
# wait - Waits for the user to press ENTER. If PROMPT_TIMEOUT is set, waits for the specified time.
# cmd - Enters interactive mode, allowing newly typed commands to be executed within the script.
# repl - Enters REPL mode, allowing newly typed commands to be executed within the script. Type 'exit' to leave REPL mode.

# SETUP environment
docker rmi $(docker images "container-demo*" -q) 2>/dev/null || true
docker builder prune -a -f
docker pull golang@sha256:927112936d6b496ed95f55f362cc09da6e3e624ef868814c56d55bd7323e0959
docker pull golang@sha256:2c49857f2295e89b23b28386e57e018a86620a8fede5003900f2d138ba9c4037
clear
# END of environment setup

# Show the v1 Dockerfile to highlight the key parts of a Dockerfile
pei "bat Dockerfile.basic.pinned -l Dockerfile"
wait
pei "docker build -t container-demo-basic -f Dockerfile.basic.pinned ."
wait
echo
echo

p "What happens when we rebuild?"
echo
echo

wait

# Show that layers caching speeds up wht docker build
pei "docker build -t container-demo-basic -f Dockerfile.basic.pinned ."
wait

echo
echo
p "What happens to build time when we add a new feature?"
echo
echo
wait

# Change that application and show that the cache is invalidated
pei "docker build -t container-demo-basic -f Dockerfile.basic.pinned ."
wait

clear

# Show the v2 Dockerfile to highlight the key parts of a Dockerfile
pei "bat Dockerfile.basic.pinned Dockerfile.cache.optimized -l Dockerfile"
echo
echo
p "Why do you think this will optimize build times?"
wait

# Get a baseline time for the build with separate COPY commands
pei "docker build -t container-demo-cache-optimized -f Dockerfile.cache.optimized ."
wait

echo
echo
p "What happens to build time when we add a new feature?"
wait
echo
echo
pei "docker build -t container-demo-cache-optimized -f Dockerfile.cache.optimized ."
wait


clear
p "Now let's explore image sizing"
echo
echo
pei "bat Dockerfile.cache.optimized Dockerfile.slim -l Dockerfile"
wait

pei "docker build -t container-demo-slim -f Dockerfile.slim ."

pei "docker images --format \"{{.Repository}}:{{.Tag}} {{.Size}}\" | rg container-demo"
wait

# Show multi-stage builds
clear
pei "bat Dockerfile.slim.multi -l Dockerfile"
wait

pei "docker build -t container-demo-slim-multi -f Dockerfile.slim.multi ."

# Show the image sizes
pei "docker images --format \"{{.Repository}}:{{.Tag}} {{.Size}}\" | rg container-demo"
wait

