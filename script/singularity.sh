#!/bin/bash

docker run \
-v /var/run/docker.sock:/var/run/docker.sock \
-v /tmp/compile-beamer:/output \
--privileged -t --rm \
singularityware/docker2singularity \
maxulysse/compile-beamer:1.5
