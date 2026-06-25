#!/usr/bin/env bash
#
# Removes the developer SDLC skills (shipped by this repo) from the current
# user's Claude Code skills directory ( $HOME/.claude/skills ).
#
# Only removes skill folders that exist in this repo's ./skills directory, so
# any unrelated skills the user has are left untouched. Installer backups
# (.backup/) are not removed.
#
# Usage:
#   ./uninstall.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/skills"
TARGET_DIR="$HOME/.claude/skills"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Nothing to remove: $TARGET_DIR does not exist."
  exit 0
fi

removed=0
for skill_path in "$SOURCE_DIR"/*/; do
  [ -d "$skill_path" ] || continue
  [ -f "${skill_path}SKILL.md" ] || continue

  name="$(basename "$skill_path")"
  dest="$TARGET_DIR/$name"
  if [ -d "$dest" ]; then
    rm -rf "$dest"
    echo "  removed: $name"
    removed=$((removed + 1))
  fi
done

echo
echo "Done. $removed skill(s) removed."
