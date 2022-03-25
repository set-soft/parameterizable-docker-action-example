#!/bin/sh -l

KICAD_VERSION=$2

echo "Creating docker image with KiCad version: $KICAD_VERSION"

ls -la /

if [ "$KICAD_VERSION" == "5" ]; then
   cd /k5
else
   cd /k6
fi

# here we can make the construction of the image as customizable as we need
# and if we need parameterizable values it is a matter of sending them as inputs
docker build -t docker-action . && docker run docker-action "$@"


