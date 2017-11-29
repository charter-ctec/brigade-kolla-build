#!/bin/sh
set -e
# Allow for debugging first:
if [ "$1" = "sh" ]; then
  exec sh
fi

# Activate the kolla-build environment:
. /root/.venv/kolla-builds/bin/activate

# Clean up any space previously left from docker builds:
#. /usr/local/bin/clean.sh

# Log into your registy:
docker login -u="$DOCKER_USER" -p="$DOCKER_PASS" $DOCKER_REGISTRY

# Attempt to run kolla-build on container entry:
kolla-build $KOLLA_PROJECT

# TEST ONLY - Push completed containers to the container registry (rework for python/golan):
# REMOVED FOR JENKINS PIPELINE TESTING
/usr/local/bin/kolla-push.sh

# END