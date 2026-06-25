#!/usr/bin/env bash
#
# Installs the developer SDLC skills into the current user's Claude Code
# skills directory ( $HOME/.claude/skills ).
#
# Copies each skill folder from this repo's ./skills directory into the
# per-user Claude skills directory. Any existing skill with the same name is
# backed up to $HOME/.claude/skills/.backup/<timestamp>/ unless --force is given.
#
# Usage:
#   ./install.sh            Install all skills, backing up any that exist.
#   ./install.sh --force    Overwrite existing skills without backup.

set -euo pipefail

FORCE=0
for arg in "$@"; do
  case "$arg" in
    --force|-f) FORCE=1 ;;
    -h|--help)
      sed -n '2,15p' "$0" | sed 's/^# \{0,1\}//'
      exit 0 ;;
    *) echo "Unknown option: $arg" >&2; exit 1 ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/skills"
TARGET_DIR="$HOME/.claude/skills"

if [ ! -d "$SOURCE_DIR" ]; then
  echo "Source skills directory not found: $SOURCE_DIR" >&2
  exit 1
fi

echo "Installing skills"
echo "  from : $SOURCE_DIR"
echo "  to   : $TARGET_DIR"
echo

mkdir -p "$TARGET_DIR"

timestamp="$(date +%Y%m%d-%H%M%S)"
installed=0
backed_up=0

for skill_path in "$SOURCE_DIR"/*/; do
  [ -d "$skill_path" ] || continue
  # Only install folders that contain a SKILL.md.
  [ -f "${skill_path}SKILL.md" ] || continue

  name="$(basename "$skill_path")"
  dest="$TARGET_DIR/$name"

  if [ -d "$dest" ]; then
    if [ "$FORCE" -eq 1 ]; then
      rm -rf "$dest"
    else
      backup_root="$TARGET_DIR/.backup/$timestamp"
      mkdir -p "$backup_root"
      mv "$dest" "$backup_root/$name"
      backed_up=$((backed_up + 1))
    fi
  fi

  cp -R "$skill_path" "$dest"
  echo "  installed: $name"
  installed=$((installed + 1))
done

echo
msg="Done. $installed skill(s) installed"
[ "$backed_up" -gt 0 ] && msg="$msg, $backed_up backed up"
echo "$msg."
[ "$backed_up" -gt 0 ] && echo "Backups: $TARGET_DIR/.backup/$timestamp"
