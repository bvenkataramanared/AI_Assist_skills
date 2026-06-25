---
name: test-gap-audit
description: Audit a codebase's test coverage suite-wide, rank the untested code by risk, then generate tests for the highest-risk gaps. Use when a developer wants to know where coverage is weakest and close the gaps that matter — not just test one function. Triggers include "where are we under-tested", "audit our test coverage", "what's the riskiest untested code", "improve coverage", or "find and fill test gaps". For tests on brand-new code use implementation; for a regression test on a fixed bug use bug-fix.
---

# Test Gap Audit

Look across the **whole codebase**, find what's untested, rank those gaps by
**risk**, and write tests for the ones that matter most. This is deliberately more
than "write a test for X" — it requires surveying the suite and modeling risk,
which a single prompt can't do well. Language- and stack-agnostic: discover the
test setup and conventions from the repo.

## When to use

- Assessing overall coverage and deciding where to invest test effort.
- Hardening risky areas before a refactor, release, or handoff.

## When NOT to use

- Tests that accompany a new feature → use `implementation`.
- A regression test pinning a specific fixed bug → use `bug-fix`.

## Workflow

### 1. Discover the test setup
- Identify the test framework(s), how tests are organized, and how coverage is
  measured/reported in this repo (config, CI, scripts). Don't assume a stack.

### 2. Map code against tests
- Build a picture of what exists vs. what's exercised: which modules, paths, and
  branches have tests and which don't. Use coverage output if available; otherwise
  reason from the code-to-test mapping.

### 3. Rank gaps by risk (the core step)
Score each untested area, don't treat all gaps equally. Weigh:
- **Criticality** — core business logic, money/data-correctness, entry points.
- **Sensitive surfaces** — **auth model**, **secrets handling**, and **known
  perf-sensitive paths** carry extra weight.
- **Complexity** — branchy logic, edge-case-heavy code, error handling.
- **Churn** — frequently changed code (from git history) breaks more often.
- **Blast radius** — widely-depended-on code (ties to `change-impact-analysis`).

### 4. Prioritize
- Produce a ranked list of the highest-risk gaps with a one-line justification
  each. Be explicit about what you are *not* covering and why.

### 5. Generate tests for the top gaps
- Write meaningful tests for the top-ranked gaps, in the repo's existing style.
  Assert real behavior and edge cases — not implementation details or trivial
  getters just to move a coverage number.

### 6. Verify
- Run the suite; confirm new tests pass and genuinely exercise the target code.
  Re-check coverage if measurable.

## Outputs

- **Coverage map:** what's tested vs. untested across the suite
- **Risk-ranked gap list:** highest-risk untested areas, each justified
- **New tests** for the top gaps, in repo style, passing
- **Explicit scope note:** gaps intentionally left, with reasons
