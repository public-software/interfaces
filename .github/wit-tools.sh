#!/usr/bin/env bash
# Installs the pinned wasm-tools and wkg releases on a GitHub-hosted x86_64 Linux runner (wit.yml).
set -euo pipefail
: "${WASM_TOOLS_VERSION:?set by wit.yml}" "${WKG_VERSION:?set by wit.yml}"
dir="$(mktemp -d)"
curl -fsSL "https://github.com/bytecodealliance/wasm-tools/releases/download/v${WASM_TOOLS_VERSION}/wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux.tar.gz" \
  | tar -xz -C "$dir"
sudo install -m 755 "$dir/wasm-tools-${WASM_TOOLS_VERSION}-x86_64-linux/wasm-tools" /usr/local/bin/wasm-tools
curl -fsSL -o "$dir/wkg" "https://github.com/bytecodealliance/wasm-pkg-tools/releases/download/v${WKG_VERSION}/wkg-x86_64-unknown-linux-gnu"
sudo install -m 755 "$dir/wkg" /usr/local/bin/wkg
wasm-tools --version
wkg --version
