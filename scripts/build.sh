#! /usr/bin/env bash

set -eou pipefail

pushd test

[[ -f "nixos.qcow2" ]] && rm "nixos.qcow2"

nixos-rebuild build-vm --flake .#base

export QEMU_OPTS="-device usb-host,vendorid=0x04e6,productid=0x581d -net user,hostfwd=tcp::2222-:22"

./result/bin/run-nixos-vm

popd
