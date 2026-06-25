---
name: incident-investigation
description: Investigate a production incident or hard-to-pin failure by correlating multiple signals — error/logs, metrics, recent deploys and code changes (git history), config/flags, and the code path — to find the root cause and contributing factors. Use when something broke in a running system and the cause isn't obvious from one stack trace. Triggers include "what caused this outage", "investigate this incident", "why did this start failing in prod", "this regressed after a deploy", or a paste of logs/alerts. For a self-contained reproducible bug use bug-fix; for pre-merge review use pr-review.
---

# Incident Investigation

Find the root cause of a production incident by **correlating evidence across
several sources** — not by reading a single stack trace. This is inherently
multi-step and multi-signal, which is why it's a skill rather than a prompt.
Language- and stack-agnostic: gather what the system actually exposes.

## When to use

- A running system broke, regressed, or degraded and the cause isn't obvious.
- The failure spans signals (logs + a deploy + a config change), not one error.

## When NOT to use

- A reproducible, self-contained bug with a clear repro → use `bug-fix`.
- Reviewing a change before merge → use `pr-review`.

## Workflow

### 1. Define the incident
- Capture the symptom, who/what is affected (blast radius), when it started, and
  severity. Establish expected vs. actual behavior.

### 2. Gather the signals
Pull together every available source — each alone is partial:
- **Errors/traces:** messages, stack traces, error-rate changes.
- **Logs & metrics:** what changed at the onset time (latency, errors, saturation).
- **Recent changes:** deploys, merges, and the git history around the onset window
  — *what shipped just before it started?*
- **Config & flags:** environment, feature-flag, or infra changes.
- **Dependencies:** upstream/downstream services, datastores, third-party outages.

### 3. Build a timeline
- Line the signals up against the onset time. Correlation with a change is the
  strongest lead — recent deploys/flags are prime suspects.

### 4. Form and test hypotheses
- Propose the most likely cause(s) and check each against the evidence. Narrow
  using bisect-style reasoning over the suspect changes. Don't stop at the first
  plausible story — confirm it explains the timeline and the symptom.

### 5. Identify root cause + contributing factors
- Separate the root cause from contributing factors and symptoms. Note impact on
  sensitive surfaces (**auth**, **secrets**, **perf-sensitive paths**).

### 6. Recommend mitigation, fix, and prevention
- **Mitigate now:** the fastest safe way to stop the bleeding (rollback, flag off).
- **Fix:** hand the underlying defect to `bug-fix` for a verified fix + regression test.
- **Prevent:** follow-ups (alerting, tests, guardrails) so it doesn't recur.

## Outputs

- **Timeline** correlating signals with changes
- **Root cause** + contributing factors, evidence-backed (with `file:line`/commit refs)
- **Mitigation** steps to stop the impact now
- **Fix handoff** to `bug-fix`, and **prevention** follow-ups
