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
docker build -t docker-action .
docker run --workdir /github/workspace \
           --rm \
           -e INPUT_KICAD \
           -e INPUT_DIR \
           -e INPUT_SKIP \
           -e INPUT_TARGETS \
           -e INPUT_CONFIG \
           -e INPUT_BOARD \
           -e INPUT_SCHEMA \
           -e INPUT_VARIANT \
           -e INPUT_VERBOSE \
           -e HOME \
           -e GITHUB_JOB \
           -e GITHUB_REF \
           -e GITHUB_SHA \
           -e GITHUB_REPOSITORY \
           -e GITHUB_REPOSITORY_OWNER \
           -e GITHUB_RUN_ID \
           -e GITHUB_RUN_NUMBER \
           -e GITHUB_RETENTION_DAYS \
           -e GITHUB_RUN_ATTEMPT \
           -e GITHUB_ACTOR \
           -e GITHUB_WORKFLOW \
           -e GITHUB_HEAD_REF \
           -e GITHUB_BASE_REF \
           -e GITHUB_EVENT_NAME \
           -e GITHUB_SERVER_URL \
           -e GITHUB_API_URL \
           -e GITHUB_GRAPHQL_URL \
           -e GITHUB_REF_NAME \
           -e GITHUB_REF_PROTECTED \
           -e GITHUB_REF_TYPE \
           -e GITHUB_WORKSPACE \
           -e GITHUB_ACTION \
           -e GITHUB_EVENT_PATH \
           -e GITHUB_ACTION_REPOSITORY \
           -e GITHUB_ACTION_REF \
           -e GITHUB_PATH \
           -e GITHUB_ENV \
           -e GITHUB_STEP_SUMMARY \
           -e RUNNER_OS \
           -e RUNNER_ARCH \
           -e RUNNER_NAME \
           -e RUNNER_TOOL_CACHE \
           -e RUNNER_TEMP \
           -e RUNNER_WORKSPACE \
           -e ACTIONS_RUNTIME_URL \
           -e ACTIONS_RUNTIME_TOKEN \
           -e ACTIONS_CACHE_URL \
           -e GITHUB_ACTIONS=true \
           -e CI=true \
           -v "/var/run/docker.sock":"/var/run/docker.sock" \
           -v "/github/home":"/github/home" \
           -v "/github/workflow":"/github/workflow" \
           -v "/github/file_commands":"/github/file_commands" \
           -v "/github/workspace":"/github/workspace" \
           docker-action "$@"


