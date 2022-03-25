#!/bin/sh -l
# This is the entrypoint for the intermediate Docker image
# It creates the real image according to the selected KiCad version

# We know this is the first arg
KICAD_VERSION=$1

echo "Creating docker image with KiCad version: $KICAD_VERSION"

ls -la

# Select the correct Dockerfile
if [ "$KICAD_VERSION" == "-k 5" ]; then
   cd /k5
else
   cd /k6
fi

ls -la /

# Create a docker image and pass all the arguments
docker build -t docker-action . && docker run docker-action "$@"


