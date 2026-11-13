#!/usr/bin/env bash

set -o xtrace -o nounset -o pipefail -o errexit

# Install a menuinst shortcut that launches the native `zellij terminal` window
# https://zellij.dev/documentation/desktop-setup.html
mkdir -p "${PREFIX}/Menu"
sed -e "s/__PKG_VERSION__/${PKG_VERSION}/g" "${RECIPE_DIR}/menu.json" > "${PREFIX}/Menu/${PKG_NAME}_menu.json"

if [[ ${target_platform} == osx-* ]]; then
    cp "${RECIPE_DIR}/zellij.icns" "${PREFIX}/Menu/zellij.icns"
else
    cp "${SRC_DIR}/zellij-utils/assets/icons/logo256.png" "${PREFIX}/Menu/zellij.png"
fi
