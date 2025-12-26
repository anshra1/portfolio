# Use Case Creation Rules (Clean Architecture + TDD)

These rules define how **use cases should be designed, implemented, and tested** when following a **design-first, contract-first** workflow with **TDD**.

The goal of a use case is **not to perform work**, but to **express business intent clearly and safely**.

---

## Rule 1 — One use case = one business intention

A use case must represent a **single, meaningful business action**.

Good examples:

* FetchFiles
* SubmitOrder
* AuthenticateUser

Bad examples:

* HandleFiles
* DoStuff
* FileService

If you cannot describe the use case in **one sentence**, it is too broad.

---

## Rule 2 — Use cases orchestrate, they do not implement

A use case:

* coordinates repositories and services
* applies business rules
* decides flow and order

A use case must NOT:

* talk to APIs
* parse JSON
* access databases
* know about frameworks

If a use case imports a data-source class, it is wrong.

---

## Rule 3 — Dependencies must be abstractions only

A use case can depend on:

* repository interfaces
* domain services
* value objects

A use case must NOT depend on:

* repository implementations
* data sources
* HTTP clients
* Flutter, Bloc, Firebase

This rule is non-negotiable.

---

## Rule 4 — Constructor injection only

All dependencies must be provided through the constructor.

Never:

* create dependencies inside a use case
* use singletons
* read from global state

This makes use cases:

* testable
* deterministic
* predictable

---

## Rule 5 — Use case input and output must be explicit

A use case must:

* take explicit input (params object or arguments)
* return explicit output

Avoid:

* reading hidden state
* mutating global state
* returning void without reason

If nothing is returned, the use case must clearly explain why.

---

## Rule 6 — Success path is defined first

When creating a use case:

1. define the success behavior
2. write tests for success
3. implement success flow

Error handling is added **after the success path is stable**.

Do not design error trees before behavior is clear.

---

## Rule 7 — Use cases must be synchronous in intent

Even if implementation is async, the **mental model** of the use case should be simple:

"Given input X, produce result Y"

Avoid use cases that:

* block indefinitely
* depend on timing
* depend on external state changes

---

## Rule 8 — One repository call per responsibility

If a use case calls multiple repositories:

* each call must serve a distinct purpose
* ordering must be intentional

If a use case merely forwards a repository call, question its necessity — but do not remove it blindly.

---

## Rule 9 — Use cases own business rules

Business rules belong in use cases, not repositories.

Examples:

* validation
* eligibility checks
* decision branching

Repositories handle data; use cases handle meaning.

---

## Rule 10 — Tests define use-case behavior

Use-case tests must verify:

* correct repository interaction
* correct decision flow
* correct output

Tests must NOT verify:

* how repositories work internally
* how data is fetched

Use-case tests are permanent unless business rules change.

---

## Rule 11 — Use cases must be framework-agnostic

A use case must not import:

* Flutter
* Bloc / Cubit
* Riverpod
* Firebase
* UI models

If you can move a use case to a pure Dart package, it is correct.

---

## Rule 12 — Name use cases as actions

Use case names must start with verbs:

* Fetch
* Create
* Update
* Delete
* Validate

This keeps intent clear and prevents service-style classes.

---

## Rule 13 — Use cases must be easy to fake

If a use case is hard to test with mocks or fakes, it is poorly designed.

Testing friction is a design smell.

---

## Rule 14 — Use cases change less than UI

Use cases represent business intent.
They should change:

* less frequently than UI
* more frequently than domain entities

If UI changes force use-case changes, boundaries are wrong.

---

## Final Principle

**Use cases are the center of the system.**

They:

* express business meaning
* protect architecture
* stabilize change

If use cases are clean, the rest of the system stays clean.
