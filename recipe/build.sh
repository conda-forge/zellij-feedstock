#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

export CARGO_PROFILE_RELEASE_STRIP=symbols
export CARGO_PROFILE_RELEASE_LTO=fat
export OPENSSL_DIR=${PREFIX}
export OPENSSL_NO_VENDOR=1

cargo-bundle-licenses \
    --format yaml \
    --output THIRDPARTY.yml

# build statically linked binary with Rust
# cargo install --bins --no-track --locked --root ${PREFIX} --path .
cargo xtask ci cross aarch64-apple-darwin

if [[ ${build_platform} == ${target_platform} ]]; then
    mkdir -p ${PREFIX}/etc/bash_completion.d
    mkdir -p ${PREFIX}/share/fish/vendor_completions.d
    mkdir -p ${PREFIX}/share/zsh/site-functions
    zellij setup --generate-completion bash > ${PREFIX}/etc/bash_completion.d/zellij
    zellij setup --generate-completion fish > ${PREFIX}/share/fish/vendor_completions.d/zellij.fish
    zellij setup --generate-completion zsh > ${PREFIX}/share/zsh/site-functions/_zellij
fi
