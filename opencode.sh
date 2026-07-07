#!/bin/sh
# dotfiles -- opencode.sh
# author: johannst

set -e

cat <<EOF > /tmp/oc-$USER.sh
apk add bash curl libstdc++

curl -fsSL https://opencode.ai/install | bash

export PATH=/root/.opencode/bin:$PATH

exec bash -li
EOF

trap "rm -f /tmp/oc-$USER.sh" EXIT

set -x
exec podman run --rm -it -v /tmp/oc-$USER.sh:/boot.sh -v $PWD:/work -w /work alpine:latest sh /boot.sh
