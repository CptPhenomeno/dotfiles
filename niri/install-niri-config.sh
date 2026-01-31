#!/bin/sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CONFIG_NAME="$1"
CONFIG_DIR="${SCRIPT_DIR}/${CONFIG_NAME}"
DEST_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/niri"

if [ -z "$CONFIG_NAME" ]; then
  echo "Error: No configuration specified."
  echo "Usage: $0 <config-name>"
  echo "Available configurations:"
  for dir in "${SCRIPT_DIR}"/*/; do
    config=$(basename "$dir")
    [ -d "$dir" ] && echo "  - $config"
  done
  exit 1
fi

if [ ! -d "$CONFIG_DIR" ]; then
  echo "Error: Configuration '$CONFIG_NAME' not found in '$SCRIPT_DIR'."
  exit 1
fi

echo "Installing niri configuration: $CONFIG_NAME"

mkdir -p "$DEST_DIR"

cp -f "$CONFIG_DIR/config.kdl" "$DEST_DIR/"

if [ -d "$CONFIG_DIR/cfg" ]; then
  mkdir -p "$DEST_DIR/cfg"
  cp -f "$CONFIG_DIR/cfg/"*.kdl "$DEST_DIR/cfg/" 2>/dev/null || true
fi

if command -v niri >/dev/null 2>&1; then
  echo "Validating niri configuration..."
  if niri validate; then
    echo "Configuration validated successfully."
  else
    echo "Error: Configuration validation failed."
    exit 1
  fi

  if niri msg action load-config-file 2>/dev/null; then
    echo "Configuration reloaded successfully."
  else
    echo "Warning: Could not reload niri. You may need to restart niri manually."
  fi
else
  echo "Warning: niri not found. Skipping validation."
fi

echo "Installation complete."
