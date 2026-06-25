# Developer Skills — Productivity for Day-to-Day Development

Claude Code skills focused on the work developers do most: building, fixing,
understanding, improving, and reviewing code. Each skill lives in its own folder
with a `SKILL.md` (YAML frontmatter + instructions).

This `skills/` directory holds the plugin's skills. The repo is packaged as a
Claude Code **plugin** (`ai_assist_skill`) via `../.claude-plugin/plugin.json`;
skills here load automatically when the plugin is installed and appear namespaced
as `/ai_assist_skill:<skill-name>`. See the top-level `../README.md` for install
steps. This `README.md` is repo documentation, not a skill.

## Design bar

Every skill here must do something **a single prompt can't reliably reproduce** —
a multi-step discipline (e.g. write the failing test *before* the fix), repo-wide
synthesis, an iteration/verification loop, or the team's encoded guardrails.
Thin "explain this / test this / document this" prompts are intentionally excluded.

## Catalog (15)

**Onboarding & ramp-up (new to the repo)**

| Skill | Use when |
|-------|----------|
| `codebase-onboarding` | Day one in an unfamiliar repo — whole-repo orientation + reading order |
| `dev-environment-setup` | Getting the app running locally |
| `change-impact-analysis` | "Where do I start, and what will my change break?" |
| `data-model-map` | Understanding entities, schema, and API/interface contracts |

**Build & change**

| Skill | Use when |
|-------|----------|
| `implementation` | Building a new feature/task (with tests) |
| `bug-fix` | Something is broken — root-cause fix + regression test |
| `refactor` | Cleaning up working code without changing behavior |

**Review & audit (repo-wide)**

| Skill | Use when |
|-------|----------|
| `pr-review` | Reviewing a PR/diff before merge |
| `test-gap-audit` | Suite-wide coverage audit, risk-ranked, then fill the top gaps |
| `dependency-health-audit` | Whole-tree dependency health + ordered upgrade plan |
| `security-review` | Security-focused pass over a change |
| `performance-optimization` | Code is correct but too slow/memory-heavy |

**Investigate & understand**

| Skill | Use when |
|-------|----------|
| `incident-investigation` | Production failure — correlate logs/deploys/history to root cause |
| `flowchart` | *Seeing* the app — visual diagram of flow & dependencies |
| `git-workflow` | Commit messages, PR descriptions, splitting commits, conflicts |

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

All 15 skills have full content (frontmatter + language-agnostic workflows +
team conventions baked in). Ready to install and use.
