---
name: explain-code
description: Explain how unfamiliar code works — trace a flow, map a module, or answer "where does X happen" in this codebase. Use when a developer is onboarding, working in an unfamiliar area, or needs to understand existing behavior before changing it. Triggers include "explain this", "how does X work", "where is Y handled", "walk me through this file", or "trace this flow". For changing code use implementation, bug-fix, or refactor instead.
---

# Explain Code

> Status: scaffold — content to be implemented.

Builds an accurate mental model of existing code: what it does, how data and
control flow through it, and where responsibilities live — so the developer can
work confidently before touching anything.

## When to use

- Onboarding to a repo or a new area of it.
- Understanding existing behavior before modifying it.

## When NOT to use

- Writing or changing code → use `implementation`, `bug-fix`, or `refactor`.

## Workflow

_To be implemented._

1. Clarify what the developer wants to understand and at what depth.
2. Locate the relevant entry points and follow the flow.
3. Map components, responsibilities, and key data structures.
4. Explain clearly, citing `file:line`, surfacing gotchas and assumptions.

## Outputs

- A clear explanation at the right altitude (overview vs. line-by-line)
- Annotated references to the relevant `file:line` locations
- Notes on edge cases, side effects, and assumptions
