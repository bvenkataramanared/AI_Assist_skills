#!/usr/bin/env bash
#
# Remove legacy *personal* copies of these skills from $HOME/.claude/skills.
#
# Earlier versions of this package installed each skill as a personal skill
# under ~/.claude/skills (invoked as /<skill-name>). The package is now a
# Claude Code *plugin*, so skills are invoked namespaced as
# /ai_assist_skill:<skill-name>. If you previously installed the personal
# copies, run this once to remove the duplicates. Only folders whose names
# match skills shipped by this package (current + known-removed) are deleted;
# unrelated skills and installer backups (.backup) are left untouched.
#
# Usage:
#   ./cleanup-legacy-skills.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_DIR="$SCRIPT_DIR/skills"
TARGET_DIR="$HOME/.claude/skills"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Nothing to clean: $TARGET_DIR does not exist."
  exit 0
fi

# Skills currently shipped by this package.
names=()
if [ -d "$SKILLS_DIR" ]; then
  for d in "$SKILLS_DIR"/*/; do
    [ -f "${d}SKILL.md" ] || continue
    names+=("$(basename "$d")")
  done
fi

# Skills shipped by older versions and since removed.
names+=(explain-code write-tests documentation debug-triage dependency-upgrade)

removed=0
for name in $(printf '%s\n' "${names[@]}" | sort -u); do
  dest="$TARGET_DIR/$name"
  if [ -d "$dest" ]; then
    rm -rf "$dest"
    echo "  removed: $name"
    removed=$((removed + 1))
  fi
done

echo
echo "Done. $removed legacy personal skill(s) removed."
echo "Now install the plugin (see README): /plugin marketplace add <repo> ; /plugin install ai_assist_skill@ai-assist-marketplace"
