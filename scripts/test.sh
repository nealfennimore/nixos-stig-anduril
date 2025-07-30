#! /usr/bin/env bash

set -eou pipefail

pushd test

nix build .#checks.x86_64-linux.machine-test

popd
