# Protocol: Bloc Architecture Enforcement

**Priority:** CRITICAL
**Goal:** Guarantee Clean Architecture and State Safety from the first line of code.

---

## 1. Setup Instructions (Do this first)

Follow these steps to arm the project with architectural safeguards:

### Step 1: Install Global CLI
Enable the `bloc` command globally on your machine.
```bash
dart pub global activate bloc_tools
```

### Step 2: Add Project Dependencies
Add the linting engines as development dependencies.
```bash
flutter pub add --dev bloc_lint custom_lint
```

### Step 3: Configure the Analyzer
Enable the `custom_lint` plugin and the `bloc:` rules in your `analysis_options.yaml`. (Refer to `docs/learning/bloc_lint.md` for the official configuration block).

---

## 2. Coding Instructions (The "Safety Net")

To maintain project integrity, you must follow these five mandates:

### Instruction 1: The "No-UI" Import Rule (`avoid_flutter_imports`)
**Mandate:** Never import `package:flutter/material.dart` or any UI library inside a Bloc/Cubit file.
*   **Why:** Logic must be platform-agnostic. UI decisions (colors/styles) belong in the Widget layer.

### Instruction 2: The Finality Mandate (`avoid_public_fields`)
**Mandate:** Every field in a BLoC State must be `final`.
*   **Why:** Prevents silent failures in change-detection. Immutability is the only way to guarantee UI updates.

### Instruction 3: Event-Driven BLoCs (`avoid_public_bloc_methods`)
**Mandate:** You must trigger BLoC logic using `bloc.add(Event)`.
*   **Why:** Forbids direct method calls on BLoCs to preserve the audit trail of events. (Note: Cubits may still use public methods).

### Instruction 4: Naming Protocol (`prefer_file_naming_conventions`)
**Mandate:** Files must be suffixed with `_bloc.dart`, `_event.dart`, or `_state.dart`.
*   **Why:** Ensures the file structure remains predictable for all developers.

### Instruction 5: Balanced Tooling (Intentional)
**Mandate:** Use `Bloc` for complex, event-driven flows. Use `Cubit` for simple state toggles.
*   **Protocol:** We intentionally leave `prefer_bloc` and `prefer_cubit` disabled to allow the right tool for the right job.

---

## 3. Verification Instructions

Before you consider a feature "Done," you must pass the Guardian check:

1.  **IDE Check:** Ensure the "Problems" tab has zero Bloc-related warnings.
2.  **Terminal Audit:** Run `bloc lint lib` for a full architecture scan.
3.  **Final Analysis:** Run `dart analyze` to ensure general quality standards are met.

**If any check fails, the architecture is broken. Fix the code before committing.**
