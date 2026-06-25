---
name: security-review
description: Review code or a diff for security issues — injection, broken authn/authz, secrets in code, unsafe deserialization, SSRF, and similar — and recommend fixes. Use when a developer wants a security-focused pass over changes, especially for code handling input, auth, or external calls. Triggers include "security review", "is this safe", "check for vulnerabilities", or "review this for security". For general correctness/quality review use pr-review.
---

# Security Review

A security-focused pass over code or a diff: find exploitable weaknesses, explain
the risk, **verify each finding is real**, and recommend concrete remediations —
prioritized by severity. This skill is **language- and stack-agnostic**: reason
about trust boundaries and the project's actual auth/secrets mechanisms. The
adversarial verify step (don't report what you can't substantiate) is what raises
this above a one-shot "find bugs" prompt.

## When to use

- Reviewing changes that touch input handling, auth, secrets, data, or external calls.
- A dedicated security pass before merge or release.

## When NOT to use

- General correctness/convention review → use `pr-review` (escalate security
  findings here).

## Workflow

### 1. Map the attack surface
- Identify trust boundaries: where untrusted input enters (requests, params,
  files, messages, env), what crosses privilege levels, and what reaches
  datastores, the filesystem, the shell, or external services.

### 2. Check the high-value classes
Focus where real vulnerabilities live, including:
- **Injection** — SQL/NoSQL/command/template/header injection from unsanitized input.
- **AuthN/AuthZ** — missing/incorrect authentication or authorization, privilege
  escalation, insecure direct object references, broken access checks (the **auth
  model**).
- **Secrets handling** — credentials/keys/tokens in code, logs, or errors; weak
  storage; secrets crossing trust boundaries.
- **Unsafe deserialization / dynamic execution** of untrusted data.
- **SSRF / path traversal / open redirects** from attacker-controlled targets.
- **Crypto** — weak algorithms, hardcoded keys, bad randomness, missing TLS verification.
- **Sensitive-data exposure** — PII/financial data logged, returned, or unprotected.
- **Dependencies** — known-vulnerable libraries (hand depth off to `dependency-health-audit`).

### 3. Verify each finding (adversarial)
- For every candidate issue, trace the actual code path and confirm it's
  genuinely exploitable — is the input really attacker-controlled and unsanitized?
  Discard or downgrade what you can't substantiate. Default to "not a finding"
  when uncertain, but note residual doubts.

### 4. Rate severity and exploitability
- Rank confirmed findings (e.g. critical / high / medium / low) by impact and how
  easily they're reached. Lead with what's exploitable now.

### 5. Recommend remediations
- For each finding give a specific, minimal fix that fits the repo's conventions
  (parameterize the query, enforce the auth check, move the secret to the repo's
  secrets mechanism). Reference safer existing patterns in the codebase.

## Outputs

- Confirmed findings ranked by severity, each with risk explanation, `file:line`,
  and why it's exploitable
- A concrete remediation per finding
- An overall risk assessment / sign-off, plus anything verified-uncertain and why
