---
name: security-review
description: Review code or a diff for security issues — injection, broken authn/authz, secrets in code, unsafe deserialization, SSRF, and similar — and recommend fixes. Use when a developer wants a security-focused pass over changes, especially for code handling input, auth, or external calls. Triggers include "security review", "is this safe", "check for vulnerabilities", or "review this for security". For general correctness/quality review use pr-review.
---

# Security Review

> Status: scaffold — content to be implemented.

A security-focused pass over code or a diff: looks for exploitable weaknesses,
explains the risk, and recommends concrete remediations — prioritized by
severity.

## When to use

- Reviewing changes that touch input handling, auth, secrets, or external calls.
- A dedicated security pass before merge or release.

## When NOT to use

- General correctness/convention review → use `pr-review`.

## Workflow

_To be implemented._

1. Identify the trust boundaries and sensitive surfaces in the change.
2. Check for common classes: injection, authn/authz gaps, secret exposure,
   unsafe deserialization, SSRF, path traversal, weak crypto.
3. Confirm each finding is real (avoid noise); assess severity and exploitability.
4. Recommend specific, minimal remediations.

## Outputs

- Findings ranked by severity, each with risk explanation and `file:line`
- Concrete remediation for each
- Overall risk assessment / sign-off
