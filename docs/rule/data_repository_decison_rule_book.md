📘 Data Repository Rule Book (v3.0)

Version: 3.0 (Strict TDD Edition)
Context: Clean Architecture Data Layer
Goal: Prevent logic leakage and enforce testing discipline.

1. Core Mandate

The Data Repository is the Strategist.

Data Source: Dumb Pipe (I/O only).

Repository: Smart Filter (Policy & Decisions).

The Golden Rule: If a Repository thinks, it must be tested.

2. The Decision Checklist (10 Categories)

A Repository method is SMART and MUST BE TESTED if it fits ANY of the following categories.

Category A: Routing (The Switch)

Logic: IF (condition) → Source A ELSE → Source B

Examples: Offline-first checks, Feature Flags, A/B Testing, User Type checks (Guest vs Logged In).

Verdict: 🧠 DECISION

Category B: Synchronization (The Side-Effect)

Logic: Fetch from Source A → Write to Source B

Examples: Write-Through caching (API → SQLite), Analytics logging, Syncing Read/Unread status.

Verdict: 🧠 DECISION

Category C: Recovery (The Safety Net)

Logic: TRY Source A → CATCH → Source B / mapped error

Examples: Silent failover to cache, Retry loops (exponential backoff), HTTP code → Domain Failure mapping.

Verdict: 🧠 DECISION

Category D: Aggregation (The Builder)

Logic: Result = Source A + Source B (+ Source C)

Examples: Scatter-Gather (Profile + Permissions), Merging local draft + remote post.

Verdict: 🧠 DECISION

Category E: Transformation (The Refiner)

Logic: filter / sort / map / compute / sanitize

Examples: Filtering inactive items, Sorting by date, Converting null lists to [], Calculating derived fields.

Verdict: 🧠 DECISION

Category F: Validation & Guarding (The Gatekeeper)

Logic: IF invalid → fail fast or normalize

Examples: Enforcing API limits (Max Page Size), Rejecting null IDs (Defensive Programming), Infrastructure integrity checks.

Verdict: 🧠 DECISION

Warning: Do not validate Business Rules here (e.g. Age > 18). That belongs in the Domain.

Category G: Caching Policy (The Memory)

Logic: IF cache valid → return cache ELSE → fetch & update

Examples: TTL (Time-To-Live) checks, Force-Refresh flags, Cache invalidation rules.

Verdict: 🧠 DECISION

Category H: Pagination / Windowing Policy

Logic: Translate domain paging → data-source paging

Examples: Offset/Limit calculation, Cursor/Token extraction and handling, Page-size enforcement.

Verdict: 🧠 DECISION

Category I: Normalization / De-duplication

Logic: Canonicalize / dedupe / merge records

Examples: Removing duplicates from combined sources, Normalizing ID formats, Collapsing repeated records.

Verdict: 🧠 DECISION

Category J: Idempotency & Write Policy

Logic: Ensure repeated calls are safe

Examples: Preventing double-posts on flaky networks, Ignoring already-applied writes, Queue management.

Verdict: 🧠 DECISION

3. The Pass-Through Standard (Strict)

A Repository method may SKIP TESTS only if it satisfies ALL conditions below:

No branching (if/switch)

No side effects (saving/logging)

No fallback (try/catch with recovery)

No aggregation

No transformation (filtering/sorting)

No validation

No caching logic

No complex pagination

No normalization

No idempotency logic

✅ Allowed (Pure Mapping)

// Pure delegation
return source.fetch().toEntity();

// Pure list mapping
return (await source.getList())
    .map((e) => e.toEntity())
    .toList();


❌ Not Allowed (Requires Test)

// Transformation detected (Category E)
return list.where((e) => e.isActive).toList(); 

// Calculation detected (Category E/H)
final offset = page * limit; 
return source.get(offset);


4. Documentation Protocol (Mandatory)

In your feature_spec.md (Phase 2.5), every method must carry this diagnostic block:

**Method:** `getProjects`

| Category | Present? | Details |
| :--- | :--- | :--- |
| Routing | No | |
| Synchronization | No | |
| Recovery | No | |
| Aggregation | No | |
| Transformation | **YES** | Sorts by DateDesc |
| Validation | No | |
| Caching | **YES** | 5 min TTL |
| Pagination | No | |
| Normalization | No | |
| Idempotency | No | |

**Verdict:** 🧠 DECISION → **WRITE REPOSITORY TEST**


5. Final Principle

Use Case: Orchestrates intent.
Repository: Enforces data policy.
Data Source: Performs I/O.

If the Repository hesitates, it is thinking.
If the Repository thinks, it must be tested.