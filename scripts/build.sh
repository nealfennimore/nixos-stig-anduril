#! /usr/bin/env bash

set -eou pipefail

pushd test

[[ -f "nixos.qcow2" ]] && rm "nixos.qcow2"

nix build .#nixosConfigurations.base.config.formats.vm

export QEMU_OPTS="-device usb-host,vendorid=0x04e6,productid=0x581d"

./result/run-nixos-vm

popd
