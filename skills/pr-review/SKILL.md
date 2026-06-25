---
name: pr-review
description: Review a pull request or a diff in any codebase for correctness, conventions, test coverage, and risk, then give clear, actionable feedback. Use when a developer wants to review someone's PR, check a branch before merge, or get a second opinion on changes. Triggers include "review this PR", "review my changes", "check this diff before merge", or a pasted PR link / diff. For writing code use implementation or bug-fix instead.
---

# PR Review

Review a change set the way a thorough senior engineer would: catch real bugs,
flag convention and test gaps, assess risk, and return prioritized, actionable
feedback — fast. This skill is **language- and stack-agnostic**: judge the change
against the project's own conventions, which you discover from the surrounding code.

## When to use

- A pull request or diff needs review before merge.
- A developer wants a second opinion on their own changes.

## When NOT to use

- Writing a new feature → use `implementation`.
- Fixing a defect → use `bug-fix`.
- A dedicated security-only pass → use `security-review`.

## Workflow

### 1. Understand the intent
- Determine what the change is supposed to do (PR description, linked story,
  commit messages). Review against that intent, not your own preferred design.

### 2. Get the diff and the context
- Look at the full diff. For anything non-trivial, read the surrounding code the
  diff touches — a change can be correct in isolation but wrong in context.
- Learn the project's conventions from neighboring code so feedback matches the
  team's established style, not personal preference.

### 3. Review across these dimensions
- **Correctness:** logic errors, off-by-one, null/empty/error handling, incorrect
  assumptions, race conditions, broken edge cases.
- **Conventions:** naming, structure, error handling, and style consistent with
  the rest of the codebase.
- **Tests:** does the change include tests for new/changed behavior? Do they
  assert real behavior and cover edge cases?
- **Security:** check the sensitive surfaces — **secrets handling** (no
  credentials in code/logs), the **auth model** (authz/authn not weakened), and
  unsafe input handling. Escalate anything serious to `security-review`.
- **Performance:** watch the **known perf-sensitive paths** — needless work in
  hot loops, N+1 queries, large allocations, blocking calls.
- **Clarity & maintainability:** readability, dead code, duplication, leftover
  debugging artifacts.

### 4. Verify findings before reporting
- Confirm each issue is real by tracing the code — avoid speculative or noisy
  comments. If unsure, say so and frame it as a question.

### 5. Report, prioritized
- Group findings by severity so the author knows what must change vs. what's optional:
  - **Blocking** — must fix before merge (bugs, security, broken tests).
  - **Should-fix** — important but not strictly merge-blocking.
  - **Nit** — minor/style/optional.
- For each finding: cite `file:line`, explain *why* it matters, and give a concrete
  suggestion. Acknowledge what's done well, too.
- End with an overall assessment: approve / approve-with-comments / request-changes.

## Outputs

- Findings grouped by severity (blocking / should-fix / nit), each with
  `file:line`, rationale, and a concrete suggestion
- Notes on test coverage, security, and performance for the change
- An overall go / no-go recommendation
