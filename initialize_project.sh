#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# Set variables for the project
IMAGE_NAME="yesod-init"
GHC_VERSION="9.2.8"
NODE_VERSION="22"
LTS_RESOLVER="lts-20.26"
PROJECT_NAME="my-yesod-project"
TEMPLATE="yesodweb/postgres"

# Build the Docker image
docker buildx build \
  --build-arg GHC_VERSION=${GHC_VERSION} \
  --build-arg NODE_VERSION=${NODE_VERSION} \
  --build-arg LTS_RESOLVER=${LTS_RESOLVER} \
  --build-arg PROJECT_NAME=${PROJECT_NAME} \
  --build-arg TEMPLATE=${TEMPLATE} \
  -f Dockerfile.init \
  -t ${IMAGE_NAME} .

# Run the Docker container and copy the project files to the host machine
docker run --rm -v "$(pwd)":/app ${IMAGE_NAME}
