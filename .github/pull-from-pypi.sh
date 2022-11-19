#!/bin/bash

set -evx

if [[ -n "$GITHUB_ACTION" ]]; then
    git fetch --tags --force
fi

# Fetch Metadata
curl -fsSL https://pypi.org/pypi/nvidia-ml-py/json 2>/dev/null > /tmp/nvidia-ml-py.json

if [ -z "$PYNVML_VERSION" ]; then
    PYNVML_VERSION=$(jq .info.version /tmp/nvidia-ml-py.json -r)
    echo "PYNVML_VERSION = $PYNVML_VERSION"
fi

CURRENT_TAG=$(git describe --abbrev=0 --tags; true)
if [ "$CURRENT_TAG" == "$PYNVML_VERSION" ]; then
    echo "Already the latest version: ${CURRENT_TAG}"
    exit 0;
fi

RELEASE_DATE="$(jq .releases[\"$PYNVML_VERSION\"][0].upload_time_iso_8601 /tmp/nvidia-ml-py.json -r)"

# Download source
rm -rf "nvidia-ml-py-${PYNVML_VERSION}" *.egg-info || true;

pip download "nvidia-ml-py==${PYNVML_VERSION}" --no-deps --no-binary :all:
tar xvzf "nvidia-ml-py-${PYNVML_VERSION}.tar.gz"
rm -rf "nvidia-ml-py-${PYNVML_VERSION}.tar.gz"

mv -f "nvidia-ml-py-${PYNVML_VERSION}"/* .
rm -rf "nvidia-ml-py-${PYNVML_VERSION}"

# Make commit
export GIT_AUTHOR_NAME="NVIDIA Corporation"
export GIT_AUTHOR_EMAIL="nvml-bindings@nvidia.com"
export GIT_COMMITTER_EMAIL="github-actions[bot]@users.noreply.github.com"
export GIT_COMMITTER_NAME="github-actions[bot]"

export GIT_AUTHOR_DATE="${RELEASE_DATE}"
test -n "$GIT_AUTHOR_DATE" && [[ "$GIT_AUTHOR_DATE" != null ]]

git add .
git commit -m "nvidia-ml-py ${PYNVML_VERSION}"
git tag -f "${PYNVML_VERSION}"
git show --stat HEAD

if [[ -n "$GITHUB_ACTION" ]]; then
    git push -u origin main --force --tags
fi
