# Bedrock AI-Assist Platform — Developer Skills

A distributable set of [Claude Code skills](https://docs.claude.com/en/docs/claude-code/skills)
focused on making developers more productive at the work they do most: building
features, fixing bugs, understanding code, and reviewing changes.

The skills are **language- and stack-agnostic** — each one discovers a project's
conventions from the repo itself, so they work in almost any codebase and language.

Clone this repo and run the installer; the skills are deployed to your **per-user**
Claude skills directory (`~/.claude/skills/`, e.g. `C:\Users\<you>\.claude\skills\`)
so they're available to Claude Code in every project you work on.

---

## Dependencies / Prerequisites

These skills are plain Markdown instructions — there is **no runtime, no package
to build, and no language-specific dependency** to install. You only need:

| Requirement | Why | Notes |
|-------------|-----|-------|
| **Claude Code** | Runs and triggers the skills | CLI, desktop, web, or IDE extension. The skills live in `~/.claude/skills/`. |
| **Git** | To clone this repo | Any recent version. |
| **A shell to run the installer** | Copies skills into place | **Windows:** PowerShell 5.1+ (built in). **macOS/Linux:** Bash. **Windows + Bash:** Git Bash also works. |
| **Mermaid-capable viewer** *(optional)* | Renders the diagrams from the `flowchart` skill | Claude Code, most IDEs, and GitHub render Mermaid automatically. Only affects how `flowchart` output is displayed. |

> The skills themselves never require Python, Node, Java, etc. When a skill needs
> to build, lint, or test a project, it uses **that project's** own toolchain,
> which it detects from the repo — nothing is assumed or installed by this package.

---

## Install

### 1. Clone the repo

```bash
git clone <repo-url>
cd AI_Assist_skills
```

### 2. Run the installer for your platform

**Windows (PowerShell):**

```powershell
./install.ps1
```

If script execution is blocked, run it for this process only:

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

**macOS / Linux / Git Bash:**

```bash
chmod +x install.sh
./install.sh
```

### 3. What the installer does

- Copies each skill folder from `./skills/` into `~/.claude/skills/`.
- Skips loose files (like `skills/README.md`) — only folders containing a
  `SKILL.md` are installed.
- If a skill of the same name already exists, it is **backed up** to
  `~/.claude/skills/.backup/<timestamp>/` before being replaced.

**Useful flags:**

| Flag | Effect |
|------|--------|
| `-WhatIf` *(PowerShell)* | Dry run — show what would happen, change nothing. |
| `-Force` *(PowerShell)* / `--force` *(bash)* | Overwrite existing skills without making a backup. |

### 4. Verify the install

```powershell
# Windows
Get-ChildItem $HOME\.claude\skills
```
```bash
# macOS / Linux / Git Bash
ls ~/.claude/skills
```

You should see the 13 skill folders listed. In Claude Code, type `/` to confirm
the skills appear, or just describe a task and the matching skill triggers.

---

## Usage

Once installed, in any project:

- **Invoke explicitly** by name, e.g. `/implementation`, `/bug-fix`, `/flowchart`.
- **Or just describe the task** — Claude triggers the matching skill based on its
  description (e.g. "fix this stack trace" → `bug-fix`; "draw the app flow" → `flowchart`).

Each skill is independent; there is no orchestrator. Skill descriptions include
"for X use Y instead" pointers so closely-related skills route cleanly.

---

## The skills (13)

### Core dev loop

| Skill | Use when | What it does |
|-------|----------|--------------|
| `implementation` | Building a new feature/task | Discovers conventions, plans, builds incrementally, adds tests, verifies against acceptance criteria |
| `bug-fix` | Something is broken | Reproduces → finds root cause → writes a failing regression test → applies the smallest fix → verifies |
| `pr-review` | Reviewing a PR/diff before merge | Reviews for correctness, conventions, tests, security & performance; returns prioritized findings (blocking/should-fix/nit) |

### Understand & improve

| Skill | Use when | What it does |
|-------|----------|--------------|
| `explain-code` | Understanding unfamiliar code | Traces flows and maps responsibilities in **prose**, with `file:line` references |
| `flowchart` | You want to *see* the structure | Reads code, builds a verified node/edge model, renders a **visual diagram** (Mermaid) of flow & dependencies |
| `write-tests` | Backfilling coverage for existing code | Finds gaps and writes meaningful tests in the project's existing style |
| `refactor` | Cleaning up working code | Behavior-preserving restructuring, guarded by tests |

### Workflow & maintenance

| Skill | Use when | What it does |
|-------|----------|--------------|
| `git-workflow` | Commits, PR descriptions, conflicts | Scopes commits, writes messages/PR text, resolves conflicts (branch naming `feature/<story_number_title>`) |
| `documentation` | Documenting finished code | Docstrings, README/CHANGELOG, API docs, ADRs — accurate to the code |
| `dependency-upgrade` | Bumping a dependency | Reads changelogs for breaking changes, updates call sites, verifies build & tests |
| `debug-triage` | Fast first pass on a failure | Interprets a stack trace / failing CI, pinpoints likely cause + next steps |

### Specialized review

| Skill | Use when | What it does |
|-------|----------|--------------|
| `performance-optimization` | Code is correct but slow | Measures first, fixes the real hotspot, proves the gain with before/after numbers |
| `security-review` | Security-focused pass | Checks injection, authn/authz, secrets, unsafe input; findings ranked by severity |

---

## Uninstall

Removes only the skills shipped by this repo; your other skills and the installer
backups are left untouched.

```powershell
./uninstall.ps1      # Windows
```
```bash
./uninstall.sh       # macOS / Linux / Git Bash
```

---

## Repository layout

```
.
├── README.md            ← this file
├── install.ps1 / .sh    ← deploy skills to ~/.claude/skills
├── uninstall.ps1 / .sh  ← remove them
└── skills/              ← source of truth (one folder per skill)
    ├── README.md            ← authoring conventions (not installed)
    ├── implementation/SKILL.md
    ├── bug-fix/SKILL.md
    ├── pr-review/SKILL.md
    ├── explain-code/SKILL.md
    ├── flowchart/SKILL.md
    ├── write-tests/SKILL.md
    ├── refactor/SKILL.md
    ├── git-workflow/SKILL.md
    ├── documentation/SKILL.md
    ├── dependency-upgrade/SKILL.md
    ├── debug-triage/SKILL.md
    ├── performance-optimization/SKILL.md
    └── security-review/SKILL.md
```

---

## Status

Full content is written for the **core dev loop** (`implementation`, `bug-fix`,
`pr-review`) and `flowchart`. The remaining skills (`explain-code`, `write-tests`,
`refactor`, `git-workflow`, `documentation`, `dependency-upgrade`, `debug-triage`,
`performance-optimization`, `security-review`) are scaffolds with frontmatter and
section skeletons in place; their workflow content is being filled in incrementally.
