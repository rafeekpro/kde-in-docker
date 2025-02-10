#!/usr/bin/env bash

set -eu
set -o pipefail

RELEASE="$1"

IMAGE="rafeekpro/kde-vnc:$RELEASE"

echo "*** BUILDING ***"

cd "$(dirname "$0")"
docker build -t "$IMAGE" . -f "$RELEASE/Dockerfile"

echo "*** PUSHING ***"
docker push "$IMAGE"
if [[ $# -gt 1 ]]
then
  docker push "$IMAGE"
fi
