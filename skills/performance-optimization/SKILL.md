---
name: performance-optimization
description: Find and fix performance problems in this codebase, guided by measurement. Use when something is slow, memory-hungry, or doesn't scale, and the developer wants hotspots identified and optimized with before/after numbers. Triggers include "this is slow", "optimize this", "reduce memory/latency", "why is X taking so long", or "make this faster". For correctness defects use bug-fix.
---

# Performance Optimization

> Status: scaffold — content to be implemented.

Improves speed, memory, or scalability by measuring first, fixing the real
hotspot, and proving the gain — not guessing.

## When to use

- Code is correct but too slow, memory-heavy, or doesn't scale.

## When NOT to use

- Code is producing wrong results → use `bug-fix`.

## Workflow

_To be implemented._

1. Define the metric and target (latency, throughput, memory).
2. Measure to find the actual hotspot — do not optimize blind.
3. Apply the smallest change that addresses the hotspot.
4. Re-measure to confirm the gain and watch for regressions.
5. Keep behavior identical; verify with tests.

## Outputs

- Identified hotspot with measured evidence
- Targeted optimization
- Before/after numbers and any trade-offs
- Tests confirming behavior is unchanged
