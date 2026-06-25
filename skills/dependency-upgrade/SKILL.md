---
name: dependency-upgrade
description: Upgrade a dependency safely — read the changelog for breaking changes, update call sites, and verify the build and tests. Use when a developer wants to bump a library, framework, or runtime version. Triggers include "upgrade X", "bump the version of", "update dependencies", "migrate to vN", or "is it safe to update". For fixing a bug caused by existing code use bug-fix.
---

# Dependency Upgrade

> Status: scaffold — content to be implemented.

Upgrades a dependency with eyes open: identifies breaking changes, updates the
affected code, and proves the project still builds and passes tests.

## When to use

- Bumping a library, framework, or runtime to a newer version.

## When NOT to use

- Fixing a defect in your own code → use `bug-fix`.

## Workflow

_To be implemented._

1. Determine current and target versions and the upgrade scope.
2. Read the changelog/release notes for breaking changes and deprecations.
3. Apply the version bump and update affected call sites.
4. Build and run the full test suite; address fallout.
5. Summarize what changed and any follow-ups needed.

## Outputs

- Updated dependency version(s)
- Adjusted call sites for breaking changes
- Passing build and tests
- Notes on remaining risks or deprecations
