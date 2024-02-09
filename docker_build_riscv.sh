#!/bin/bash
set -e
if [ ! -e gcc-base ]; then
	git submodule update --init --recursive
fi
source gcc-base/docker_build_helper.sh

prepare_container buster

BUILD="$(gcc -dumpmachine)"
TARGET="riscv32-unknown-elf"
for HOST in "$BUILD" "x86_64-w64-mingw32"; do
	docker exec -i gcc_multilib bash /scripts/build.sh "$HOST" "$TARGET"
done

cleanup_container

exit 0
