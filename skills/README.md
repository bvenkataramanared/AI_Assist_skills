# Developer Skills — Productivity for Day-to-Day Development

Claude Code skills focused on the work developers do most: building, fixing,
understanding, improving, and reviewing code. Each skill lives in its own folder
with a `SKILL.md` (YAML frontmatter + instructions).

This `skills/` directory is the **source of truth**. The repo installer
(`../install.ps1` / `../install.sh`) copies each skill folder here into the user's
`~/.claude/skills/` directory. This `README.md` is repo documentation and is **not**
installed (the installer copies only folders containing a `SKILL.md`).

## Catalog

**Core dev loop**

| Skill | Use when |
|-------|----------|
| `implementation` | Building a new feature/task (with tests) |
| `bug-fix` | Something is broken — root-cause fix + regression test |
| `pr-review` | Reviewing a PR/diff before merge |

**Understand & improve**

| Skill | Use when |
|-------|----------|
| `explain-code` | Understanding unfamiliar code or tracing a flow (prose) |
| `flowchart` | *Seeing* the app — visual diagram of flow & dependencies |
| `write-tests` | Backfilling/strengthening coverage for existing code |
| `refactor` | Cleaning up working code without changing behavior |

**Workflow & maintenance**

| Skill | Use when |
|-------|----------|
| `git-workflow` | Commit messages, PR descriptions, splitting commits, conflicts |
| `documentation` | Docstrings, README/CHANGELOG, API docs, ADRs |
| `dependency-upgrade` | Bumping a library/framework/runtime safely |
| `debug-triage` | Fast first pass on a stack trace / failing CI |

**Specialized review**

| Skill | Use when |
|-------|----------|
| `performance-optimization` | Code is correct but too slow/memory-heavy |
| `security-review` | Security-focused pass over a change |

Each skill is independent — there is no orchestrator. A developer invokes the one
that matches the task (or just describes it and Claude triggers the right skill).
Descriptions include "for X use Y instead" pointers so closely-related skills
route cleanly.

## Authoring conventions

- One skill per folder; the folder name matches the `name:` in frontmatter.
- Frontmatter requires `name` and `description`. The `description` is what Claude
  uses to decide when to trigger the skill — keep it specific, include trigger
  phrases, and state when NOT to use it (to avoid overlap between skills).
- Keep `SKILL.md` focused; move long reference material or scripts into the
  skill folder and link to them.

## Status

All skills are currently **scaffolds** — frontmatter and section skeletons are
in place; workflow content is being filled in incrementally.
