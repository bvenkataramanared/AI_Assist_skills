---
name: debug-triage
description: Quickly triage a failure — a stack trace, error log, or failing CI run — to pinpoint the likely cause and the next concrete steps. Use when a developer has a symptom and wants fast direction before committing to a full fix. Triggers include "what's causing this error", "triage this stack trace", "why is CI failing", or a pasted error/log. For actually implementing the fix afterwards use bug-fix.
---

# Debug Triage

> Status: scaffold — content to be implemented.

A fast, lightweight first pass on a failure: reads the trace/log, localizes the
likely cause, and hands back a short list of next steps — without yet committing
to a full fix.

## When to use

- A stack trace, error log, or failing CI/test needs interpreting.
- The developer wants direction before diving into a fix.

## When NOT to use

- Producing the actual fix + regression test → use `bug-fix`.

## Workflow

_To be implemented._

1. Parse the error/stack trace/log and extract the key signal.
2. Map it to the relevant code and recent changes.
3. Form the most likely hypothesis (and a backup or two).
4. Recommend the next concrete steps (repro, log, fix, or hand to bug-fix).

## Outputs

- Most likely cause, with reasoning and `file:line` references
- Alternative hypotheses if uncertain
- Concrete next steps
