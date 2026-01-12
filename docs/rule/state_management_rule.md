# Clean Role of State Management in Clean Architecture

This document defines **strict, enforceable rules** for how state management (BLoC, Cubit, ViewModel, etc.) must behave in a Clean Architecture Flutter project. These rules are designed to be followed by **AI code generators and reviewers**.

---

## 1. Primary Responsibility

State management exists **only to manage UI state**.

It acts as a **coordinator between the UI and the domain layer**.

**State management MUST:**

* Receive user-driven events
* Call domain use cases
* Map domain results to UI states
* Expose immutable state to the UI

**State management MUST NOT:**

* Contain business rules
* Perform data fetching
* Access APIs, databases, or caches
* Parse or serialize JSON
* Know about data source implementations

---

## 2. Layer Ownership

State management belongs strictly to the **Presentation Layer**.

It may depend on:

* Domain use cases
* Domain entities (read-only)
* Presentation-level models (if needed for UI shaping)

It must never depend on:

* Data layer implementations
* Framework-specific networking or persistence APIs

---

## 3. Dependency Direction

Allowed dependency direction:

```
UI → State Management → Use Case → Repository Interface
```

Forbidden dependency direction:

```
State Management → Repository Implementation
State Management → Data Source
State Management → API / DB / Cache
```

All dependencies must point **inward** toward the domain.

---

## 4. Event Handling Rules

Each event handled by state management must:

* Represent a **single user intent**
* Trigger **at most one use case**
* Produce a **deterministic state transition**

Events must not:

* Trigger chained business workflows
* Coordinate multiple use cases with business logic
* Contain conditional domain decisions

Complex workflows belong in the **domain layer**, not in state management.

---

## 5. State Design Rules

States must:

* Be immutable
* Represent a complete UI snapshot
* Be serializable if needed for debugging

States should represent:

* Initial
* Loading
* Success (with data)
* Error (with failure info)

States must not:

* Contain framework controllers (TextEditingController, AnimationController)
* Contain mutable collections
* Contain domain-side logic

---

## 6. Error Handling Rules

State management:

* Receives failures from use cases
* Maps failures to UI-friendly error states

It must not:

* Decide error recovery strategies
* Retry business operations
* Translate low-level exceptions

All error semantics belong to the **domain layer**.

---

## 7. Validation Rules

State management may perform:

* Basic UI validation (empty field, format check)

State management must not perform:

* Domain validation
* Business invariants
* Cross-field business rules

If validation affects business correctness, it belongs in a **use case**.

---

## 8. Time and Lifecycle Rules

State management:

* May react to lifecycle events (init, dispose)
* May cancel in-flight UI-triggered operations

It must not:

* Own long-running business processes
* Schedule background jobs
* Persist state across app launches

---

## 9. Testability Rules

State management must be:

* Fully testable without Flutter UI
* Testable by mocking use cases

Tests should assert:

* Event → State transitions
* Correct use case invocation
* Correct error mapping

---

## 10. Replaceability Rule

State management must be replaceable without affecting:

* Domain layer
* Data layer

Changing BLoC to Cubit, Riverpod, or another solution must not require domain changes.

---

## 11. AI Enforcement Rules

An AI system reviewing or generating code must:

* Reject state classes containing business logic
* Reject direct data-layer access
* Flag multiple use case orchestration
* Enforce immutability of state
* Enforce strict layer boundaries

If a rule is violated, the AI must:

* Identify the violation
* Explain which rule is broken
* Suggest a compliant refactor

---

## Summary (Non-negotiable)

State management is a **thin orchestration layer**.

If it starts to think, decide, fetch, or calculate beyond UI needs, the architecture is broken.
