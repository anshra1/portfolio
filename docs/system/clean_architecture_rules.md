# AI Code Generation Guidelines - Clean Architecture & Project Standards

This document is the **source of truth** for code structure, responsibility, and architectural standards.

---

## 1. The Core Philosophy & Constraints

### 🧠 The Mental Model: "Who says 'No'?"
To decide where logic belongs, ask: **"Who has the authority to stop this action?"**
*   **OS / Device says 'No'** → **UI / Presentation** (e.g., "Screen too small", "Double tap ignored")
*   **Infrastructure says 'No'** → **Data Layer** (e.g., "No internet", "Disk full", "Server 500")
*   **Product Rules say 'No'** → **Domain Layer** (e.g., "User not admin", "Balance insufficient", "Limit reached")

### 🛡️ The Dependency Rule (Strict Imports)
Dependencies must point **INWARDS** towards the Domain.
*   ✅ **Presentation** depends on **Domain**.
*   ✅ **Data** depends on **Domain**.
*   ❌ **Domain** depends on **NOTHING** (Standard Library only).
*   ❌ **Domain** NEVER imports `package:flutter`, `package:dio`, `package:firebase`, or any Data/UI classes.

### 📦 The Data Flow Contract
*   **DTOs (Data Transfer Objects):** exist **ONLY** in the Data Layer. They **NEVER** return to the Domain or UI.
*   **Entities:** are the **ONLY** objects allowed to cross boundaries.
*   **Flow:** `Datasource (returns DTO)` → `Repository (maps DTO to Entity)` → `UseCase (returns Entity)` → `Bloc (uses Entity)`.

---

## 2. Domain Layer (The "Product Truth")
**Path:** `lib/core/domain/` or `lib/features/<feature>/domain/`

**Role:** The guardian of product correctness. Logic here is **unconditional** and **technology-agnostic**.

### ✅ What Belongs Here (The 9 Rule Types)
1.  **Validity:** "Task title cannot be empty." (If violated, product is broken).
2.  **Permission:** "Only owner can delete."
3.  **Quantity/Limits:** "Free tier max 5 projects."
4.  **State Transitions:** "Cannot move from 'Delivered' to 'Shipped'."
5.  **Field Dependencies:** "Urgent tasks must have a due date."
6.  **Monetary/Pricing:** "Refunds only within 30 days."
7.  **Time-based:** "Login bonus once per day."
8.  **Data Invariants:** "Email must be unique."
9.  **Workflow Sequence:** "Payment must complete before Order Confirmation."

### ❌ What MUST NOT be here
*   **Flutter Code:** No `BuildContext`, Widgets, or UI logic.
*   **Infrastructure:** No HTTP, JSON, Database, or Firebase.
*   **User Messages:** Domain errors are technical facts (`InvalidTitle`), not user strings (`"Please enter a title"`).

---

## 3. Data Layer (The "Infrastructure")
**Path:** `lib/core/data/` or `lib/features/<feature>/data/`

**Role:** Execution and orchestration of data retrieval.

### A. Repositories (The "Decision Maker")
*   **Implements:** Domain Repository Interface.
*   **Responsibilities:**
    *   **Decide Strategy:** Local vs. Remote, Offline-first, Cache-refresh.
    *   **Orchestrate:** "Fetch remote -> Save local -> Return local."
    *   **Map Errors:** Catch `DioException` -> Throw `ServerFailure`.
    *   **Map Data:** Convert `UserDto` -> `UserEntity`.
    *   **Cross-Cutting:** Trigger **Analytics** and **Crash Reporting**.
*   **Rule:** "Decides WHAT, WHEN, and WHY data is accessed."

### B. Datasources (The "Dumb Executor")
*   **Responsibilities:**
    *   **Raw I/O:** HTTP GET, Database Query, File Read.
    *   **Serialization:** JSON ↔ DTO.
    *   **Throw Technical Errors:** `Http500`, `SocketException`.
*   **Rule:** Stateless execution only. No business logic. No decision making.

---

## 4. Presentation Layer (The "UI")
**Path:** `lib/features/<feature>/presentation/`

**Role:** Visualizing state and capturing user intent.

### A. State Management (Bloc/Cubit)
*   **Responsibilities:**
    *   **Screen States:** Loading, Success, Error, Empty, Idle.
    *   **UX Guard Logic:** Ignoring double taps, debouncing search, disabling buttons while saving.
    *   **UI Transformation:** Mapping `Domain User` -> `UserUiModel` (e.g., formatting dates).
    *   **Filtering/Sorting:** "Show only completed tasks" (Visual preference, not business rule).
*   **Rule:** "Interprets system results for the UI."

### B. UI Widgets (The "Renderer")
*   **Responsibilities:**
    *   **Pure Rendering:** `if (state is Loading) return Spinner();`
    *   **Trivial Formatting:** Colors, Icons, Padding.
    *   **Wiring Actions:** `onTap: () => cubit.submit()`
*   **Rule:** Dumb, minimal, and visual-only.

---

## 5. Cheat Sheet: Where Does It Go?

| Scenario | Layer | Why? |
| :--- | :--- | :--- |
| **"Email format is invalid"** | **Domain** | Data invariant / Validity rule. |
| **"Show error text in red"** | **UI** | Visual formatting. |
| **"Retry HTTP request 3 times"** | **Repository** | Data access policy / Infrastructure strategy. |
| **"JSON parsing"** | **Datasource** | Technical serialization. |
| **"User cannot save while loading"** | **State Manager** | UX Guard Logic. |
| **"Free users can't upload video"** | **Domain** | Business limit rule. |
| **"Log 'purchase_failed' event"** | **Repository** | Cross-cutting concern. |
| **"Format date as 'Mon, Dec 22'"** | **State Manager** | UI-specific data transformation. |

---

## 6. Testing Strategy
*   **Domain:** **100% Coverage.** Pure Dart. No mocks needed for IO.
*   **Repository:** Test orchestration and error mapping. Mock Datasources.
*   **State Management:** Test state transitions and UX logic. Mock Use Cases.
