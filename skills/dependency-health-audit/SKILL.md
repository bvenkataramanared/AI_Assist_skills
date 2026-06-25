---
name: dependency-health-audit
description: Audit the whole dependency tree of a project — outdated, vulnerable, unused, and unmaintained dependencies — and produce a prioritized, interdependency-aware upgrade plan. Use when a developer wants the overall health of their dependencies and a safe order to act, not just to bump one library. Triggers include "audit our dependencies", "what's outdated/vulnerable", "are there unused dependencies", "plan our upgrades", or "dependency health check". For making the code changes a single major upgrade requires, hand off to implementation.
---

# Dependency Health Audit

Assess the health of a project's **entire** dependency tree and produce a safe,
ordered upgrade plan. This is cross-cutting analysis plus planning across
interdependent packages — beyond a one-shot "bump library X". Language- and
stack-agnostic: read whatever manifests and lockfiles the project uses.

## When to use

- Understanding overall dependency health (security, staleness, bloat).
- Planning a round of upgrades in a safe order.

## When NOT to use

- Writing the code changes a major upgrade forces → use `implementation`.
- Reviewing a dependency-bump PR → use `pr-review`.

## Workflow

### 1. Inventory the dependencies
- Enumerate direct and (where visible) transitive dependencies from the project's
  manifests and lockfiles. Identify each one's current version.

### 2. Assess each dependency
- **Outdated:** current vs. latest; how many majors/minors behind.
- **Vulnerable:** known security advisories affecting the used version.
- **Unused / redundant:** declared but not imported, or duplicated capability.
- **Unmaintained:** abandoned or deprecated packages.
- **License:** flags if license constraints matter to the project.
- Use the ecosystem's own audit tooling where the repo provides it; otherwise
  reason from versions and changelogs.

### 3. Classify and prioritize
- Rank findings by severity/urgency: security vulnerabilities first, then risky
  staleness, then cleanup (unused) and nice-to-haves.

### 4. Plan the upgrade order (the core step)
- Sequence upgrades accounting for **interdependencies** and **breaking changes**
  (read changelogs/release notes for majors). Batch low-risk patch/minor bumps
  together; isolate risky majors so failures are easy to bisect.
- For each batch, note the verification (build + tests) and a rollback point.

### 5. Verify as you go (if executing)
- If applying upgrades, do it batch by batch: apply → build → test → confirm before
  the next batch. Stop and isolate on any failure.

## Outputs

- **Health report:** outdated / vulnerable / unused / unmaintained, per dependency
- **Prioritized findings:** security-critical first
- **Ordered upgrade plan:** batched, interdependency- and breaking-change-aware,
  with per-batch verification and rollback notes
- Hand off to `implementation` for the code changes a major upgrade requires
