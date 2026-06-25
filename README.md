# Bedrock AI-Assist Platform — Developer Skills

A [Claude Code **plugin**](https://code.claude.com/docs/en/plugins) of skills
focused on making developers more productive at the work they do most: ramping up
on a repo, building features, fixing bugs, and reviewing/auditing changes.

The skills are **language- and stack-agnostic** — each one discovers a project's
conventions from the repo itself, so they work in almost any codebase and language.

Installed as a plugin, the skills appear **namespaced** in Claude Code as
`/ai_assist_skill:<skill-name>` (e.g. `/ai_assist_skill:bug-fix`), so they're
clearly grouped and never collide with your other skills.

---

## Dependencies / Prerequisites

These skills are plain Markdown instructions — there is **no runtime, no package
to build, and no language-specific dependency** to install. You only need:

| Requirement | Why | Notes |
|-------------|-----|-------|
| **Claude Code** | Runs the plugin and triggers the skills | A version with plugin support (`/plugin` command). |
| **Git** | To clone / fetch this repo | Any recent version. |
| **Mermaid-capable viewer** *(optional)* | Renders the diagrams from `flowchart` / `data-model-map` | Claude Code, most IDEs, and GitHub render Mermaid automatically. Only affects how diagram output is displayed. |

> The skills themselves never require Python, Node, Java, etc. When a skill needs
> to build, lint, or test a project, it uses **that project's** own toolchain,
> which it detects from the repo — nothing is assumed or installed by this package.

---

## Install (as a plugin)

This repo is both a **plugin** (`ai_assist_skill`) and a one-plugin **marketplace**
(`ai-assist-marketplace`). Install it once and the skills are available namespaced
in every project.

### Option A — from a local clone

```bash
git clone <repo-url>
```

Then, inside Claude Code, add this repo as a marketplace and install the plugin
(use the path to your clone):

```text
/plugin marketplace add ./AI_Assist_skills
/plugin install ai_assist_skill@ai-assist-marketplace
```

### Option B — straight from git (once hosted)

```text
/plugin marketplace add <github-owner>/<repo>
/plugin install ai_assist_skill@ai-assist-marketplace
```

### Verify

In Claude Code, type `/` and you should see the skills listed as
`/ai_assist_skill:…`. To update later, push changes and run
`/plugin marketplace update`.

> **Upgrading from the old version?** Earlier builds installed these as *personal*
> skills under `~/.claude/skills/` (un-namespaced `/bug-fix`, etc.). Those now
> duplicate the plugin. Remove them once with `./cleanup-legacy-skills.ps1`
> (Windows) or `./cleanup-legacy-skills.sh` (macOS/Linux) — it only deletes copies
> of skills this package shipped.

---

## Usage

Once installed, in any project:

- **Invoke explicitly** by namespaced name, e.g. `/ai_assist_skill:implementation`,
  `/ai_assist_skill:bug-fix`, `/ai_assist_skill:flowchart`.
- **Or just describe the task** — Claude triggers the matching skill based on its
  description (e.g. "fix this stack trace" → `bug-fix`; "draw the app flow" → `flowchart`).

Each skill is independent; there is no orchestrator. Skill descriptions include
"for X use Y instead" pointers so closely-related skills route cleanly.

---

## The skills (15)

Every skill earns its place by encoding something a single prompt can't reliably
do: a multi-step discipline, repo-wide synthesis, an iteration/verification loop,
or your team's guardrails. (Thin "explain this / test this / document this"
prompts were deliberately left out.)

### Onboarding & ramp-up (new to the repo)

| Skill | Use when | What it does |
|-------|----------|--------------|
| `codebase-onboarding` | Day one in an unfamiliar repo | Whole-repo orientation: what it is, stack, structure, how to run, conventions, doc gaps, and a suggested reading order (README-aware, code-verified) |
| `dev-environment-setup` | Getting the app running locally | Detects prerequisites, env/config, and the exact install → build → run → verify steps, with gotchas |
| `change-impact-analysis` | "Where do I start, what will break?" | Locates where a change belongs and maps its blast radius (callers, contracts, tests, config, downstream) with a risk read |
| `data-model-map` | Understanding the data & contracts | Maps entities, relationships, schema/migrations, and the API/interface surface — reference + Mermaid diagram |

### Build & change

| Skill | Use when | What it does |
|-------|----------|--------------|
| `implementation` | Building a new feature/task | Discovers conventions, plans, builds incrementally, adds tests, verifies against acceptance criteria |
| `bug-fix` | Something is broken | Reproduces → finds root cause → writes a failing regression test → applies the smallest fix → verifies |
| `refactor` | Cleaning up working code | Behavior-preserving, test-guarded restructuring in safe steps |

### Review & audit (repo-wide)

| Skill | Use when | What it does |
|-------|----------|--------------|
| `pr-review` | Reviewing a PR/diff before merge | Reviews for correctness, conventions, tests, security & performance; verifies findings; prioritizes (blocking/should-fix/nit) |
| `test-gap-audit` | Where is coverage weakest? | Surveys the whole suite, ranks untested code by risk, then writes tests for the top gaps |
| `dependency-health-audit` | Dependency health & upgrade plan | Audits the whole tree (outdated/vulnerable/unused) and produces an ordered, interdependency-aware upgrade plan |
| `security-review` | Security-focused pass | Checks injection, authn/authz, secrets, unsafe input; verifies findings; ranks by severity |
| `performance-optimization` | Code is correct but slow | Measures first, fixes the real hotspot, proves the gain with before/after numbers |

### Investigate & understand

| Skill | Use when | What it does |
|-------|----------|--------------|
| `incident-investigation` | A production failure with no obvious cause | Correlates logs, metrics, recent deploys & git history into a timeline → root cause → mitigation + fix handoff |
| `flowchart` | You want to *see* the structure | Reads code, builds a verified node/edge model, renders a **visual diagram** (Mermaid) of flow & dependencies |
| `git-workflow` | Commits, PR descriptions, conflicts | Scopes commits, writes messages/PR text, splits diffs, resolves conflicts (branch naming `feature/<story_number_title>`) |

---

## Uninstall

In Claude Code:

```text
/plugin uninstall ai_assist_skill@ai-assist-marketplace
/plugin marketplace remove ai-assist-marketplace   # optional: also drop the marketplace
```

---

## Repository layout

```
.
├── README.md                    ← this file
├── .claude-plugin/
│   ├── plugin.json              ← plugin manifest (name: ai_assist_skill → the prefix)
│   └── marketplace.json         ← one-plugin marketplace (name: ai-assist-marketplace)
├── cleanup-legacy-skills.ps1/.sh ← remove old un-namespaced personal copies (migration)
└── skills/                      ← the plugin's skills (one folder per skill)
    ├── README.md                    ← authoring conventions
    ├── codebase-onboarding/SKILL.md
    ├── dev-environment-setup/SKILL.md
    ├── change-impact-analysis/SKILL.md
    ├── data-model-map/SKILL.md
    ├── implementation/SKILL.md
    ├── bug-fix/SKILL.md
    ├── refactor/SKILL.md
    ├── pr-review/SKILL.md
    ├── test-gap-audit/SKILL.md
    ├── dependency-health-audit/SKILL.md
    ├── security-review/SKILL.md
    ├── performance-optimization/SKILL.md
    ├── incident-investigation/SKILL.md
    ├── flowchart/SKILL.md
    └── git-workflow/SKILL.md
```

---

## Status

**All 15 skills have full content** — frontmatter, language-agnostic workflows,
the team conventions (branch naming, secrets/auth/perf guardrails) baked in, and
clean cross-skill routing. The package is ready to install and use.
