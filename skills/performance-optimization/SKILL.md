---
name: performance-optimization
description: Find and fix performance problems in any codebase, guided by measurement. Use when something is slow, memory-hungry, or doesn't scale, and the developer wants hotspots identified and optimized with before/after numbers. Triggers include "this is slow", "optimize this", "reduce memory/latency", "why is X taking so long", or "make this faster". For correctness defects use bug-fix.
---

# Performance Optimization

Improve speed, memory, or scalability by **measuring first**, fixing the real
hotspot, and proving the gain with numbers — never by guessing. This skill is
**language- and stack-agnostic**: use whatever profiling/measurement the project
and its ecosystem provide. The measure → change → re-measure loop is what makes
this a skill, not a one-shot "optimize this."

## When to use

- Code is correct but too slow, memory-heavy, or doesn't scale.

## When NOT to use

- Code produces wrong results → use `bug-fix`.
- You only need a coverage/quality pass → use `pr-review` / `test-gap-audit`.

## Workflow

### 1. Define the goal and metric
- State what "fast enough" means: the metric (latency, throughput, memory,
  startup, cost) and a target. Without a target you can't know when to stop.

### 2. Establish a baseline
- Reproduce the slow scenario with a representative workload and **measure** it.
  Capture the baseline number(s). Optimizing without a baseline is guessing.

### 3. Find the real hotspot
- Profile or instrument to locate where the time/memory actually goes. Confirm the
  bottleneck with data — intuition about hotspots is often wrong. Look for the
  usual structural causes: needless work in hot loops, N+1 queries, missing
  caching/indexes, excessive allocations, blocking I/O, accidental quadratic
  behavior. (`change-impact-analysis` helps trace what the hot path touches.)

### 4. Apply the smallest effective change
- Address the dominant hotspot first with the least invasive change that fits the
  repo's conventions. Preserve behavior exactly — performance work must not change
  results. Avoid micro-optimizations that don't move the metric.

### 5. Re-measure and compare
- Measure again under the same workload. Report before/after numbers and confirm
  the target is met. Watch for regressions elsewhere (a speedup that increases
  memory, or helps one path and hurts another).

### 6. Verify correctness
- Run the test suite to prove behavior is unchanged. Note any trade-offs (memory
  vs. speed, added complexity, cache invalidation) so they're a conscious choice.

## Outputs

- The goal/metric and a measured **baseline**
- The hotspot, identified with profiling/measurement evidence (with `file:line`)
- A targeted optimization that preserves behavior
- **Before/after numbers** vs. the target, plus any trade-offs
- A green test run confirming unchanged behavior
