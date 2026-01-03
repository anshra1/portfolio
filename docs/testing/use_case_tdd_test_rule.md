 **Master Rule Set for TDD Usecase Test Creation**.


# Use Case Creation Rules (Clean Architecture + TDD)

These rules define how **use cases should be designed, implemented, and tested** using `dartz` for functional error handling and `faker` for test data generation.

The goal of a use case is **not to perform work**, but to **express business intent clearly and safely**.

---

## Rule 1 — One use case = one business intention

A use case must represent a **single, meaningful business action**.

Good examples:

* `FetchFiles`
* `SubmitOrder`
* `AuthenticateUser`

Bad examples:

* `HandleFiles`
* `DoStuff`
* `FileService`

If you cannot describe the use case in **one sentence**, it is too broad.

---

## Rule 2 — Use cases orchestrate, they do not implement

A use case:

* coordinates repositories and services
* applies business rules
* decides flow and order

A use case must NOT:

* talk to APIs directly
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
* data sources (DTOs)
* HTTP clients
* Flutter, Bloc, Firebase

This rule is non-negotiable.

---

## Rule 4 — Constructor injection only

All dependencies must be provided through the constructor.

Never:

* create dependencies inside a use case
* use singletons (e.g., `GetIt.I`)
* read from global state

This makes use cases testable, deterministic, and predictable.

---

## Rule 5 — Explicit Input via Command Objects

A use case must take explicit input.

* If the use case requires **more than 2 parameters**, they must be encapsulated in a named parameter class (e.g., `SubmitOrderParams`).
* Avoid long lists of positional arguments.
* Do not read hidden state; pass everything in.

---

## Rule 6 — Success path is defined first

When creating a use case:

1. Define the success behavior.
2. Write tests for success.
3. Implement success flow.

Error handling is added **after the success path is stable**. Do not design complex error trees before the happy path is working.

---

## Rule 7 — Use cases must be synchronous in intent

Even if implementation is `async`/`Future`, the **mental model** should be simple:
"Given input X, produce result Y."

Avoid use cases that block indefinitely or depend on complex external state changes (like listening to streams indefinitely).

---

## Rule 8 — Orchestration Logic belongs in the Use Case

If a use case calls multiple repositories (e.g., fetch User from Repo A, then fetch Orders from Repo B using UserID):

* The logic to pass data from A to B belongs in the **Use Case**.
* Do not create "Mega-Repositories" just to handle this orchestration.
* Ordering of calls must be intentional.

---

## Rule 9 — Use cases own business rules

Business rules belong in use cases, not repositories.
Examples:

* Validation (is the user old enough?)
* Eligibility checks
* Decision branching

Repositories handle data I/O; use cases handle meaning.

---

## Rule 10 — Tests define behavior (using Faker)

Use-case tests must verify:

* Correct repository interaction (using mocks).
* Correct decision flow.
* Correct output.

**Data Generation:**

* Use the **`faker`** package to generate random, realistic test data strings, numbers, and dates.
* Do not use hardcoded magic strings like "test" or "123" unless specifically testing for that exact value.

---

## Rule 11 — Use cases must be framework-agnostic

A use case must not import:

* Flutter (UI widgets)
* Bloc / Cubit / Riverpod
* Firebase SDKs
* UI models

If you can move the use case file to a pure Dart package, it is correct.

---

## Rule 12 — Name use cases as actions

Use case names must start with verbs:

* `Get`, `Create`, `Update`, `Delete`, `Validate`

This keeps intent clear and prevents service-style classes.

---

## Rule 13 — Use cases must be easy to fake

If a use case is hard to test with mocks, it is poorly designed. Testing friction is a design smell indicating tight coupling.

---

## Rule 14 — Use cases change less than UI

Use cases represent business intent. If a button color change or a UI redesign forces you to rewrite a Use Case, the architectural boundaries are broken.

---

## Rule 15 — Functional Error Handling (No Exceptions)

Use cases **must never throw exceptions** for expected business failures.
You must use the **`dartz`** package.

* Return type must be `Future<Either<Failure, Type>>`.
* **Left** side always contains a `Failure` object.
* **Right** side contains the success data.

**Bad:**
`Future<User> call(...)` (Implies it cannot fail or will crash via Exception)

**Good:**
`Future<Either<Failure, User>> call(...)` (Explicitly handles failure)

---

## Rule 16 — Callable Class Syntax

Use cases must implement the `call()` method.
This allows the instance to be invoked like a function.

**Correct Usage:**

```dart
final result = await verifyUser(params);

```

**Incorrect Usage:**

```dart
final result = await verifyUser.execute(params); // Do not use arbitrary method names

```

---

## Rule 17 — The DTO Firewall

* **Input:** Must be a Domain Entity, Value Object, or Primitive.
* **Output:** Must be a Domain Entity or Value Object.

**Strictly Prohibited:**
Passing DTOs (Data Transfer Objects), JSON wrappers, or generated API response classes into or out of a use case. The Use Case is the barrier where DTOs are forbidden.

---

## Final Principle

**Use cases are the center of the system.**

If use cases are clean, the rest of the system stays clean.