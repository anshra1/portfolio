Plain-English Method Design Shell

This shell defines what must be written and why it exists before any test or code is written. It enforces Clean Architecture, deterministic TDD, and strict ownership of external influence.

1. Project Feature Name

Role:
Defines the business capability this method belongs to. Anchors all design decisions to product intent.

2. Method Name

Role:
Defines a single, testable unit of behavior. Acts as the hard scope boundary for responsibilities, tests, and implementation.

3. Method Responsibility

Role:
Defines exactly what the method is accountable for and what it must not do. Locks scope and enforces single responsibility. All behavior, tests, and logic must map to these responsibilities.

Format:

Must be a bulleted list.

Each bullet represents one distinct responsibility.

Anything not listed here is out of scope.

4. Datasource (The Mechanism)

Focus: Pure IO interaction. No business decisions.

4.1  Full Method Working (Plain English)

Role: Describes datasource behavior step by step using natural language. Defines pure IO interaction without decisions or interpretation.

4.2 Context & Inputs

Role: Lists every external influence required by the Datasource to execute.

Includes:

Services: External clients (HTTP Client, Local Storage, Bluetooth Driver) needed to perform the IO.

Data: Arguments (IDs, Raw JSON, Models) passed into the function to drive the IO.

Constraint: Any service or variable not listed here is forbidden in the Full Method Working section.

4.3 Edge Cases

Role:
Identifies abnormal or failure scenarios the datasource may encounter (e.g., Network Timeout, Malformed JSON, Permission Denied). Ensures IO failure behavior is explicit and testable.

4.4 Architectural Decisions

Role:
Records constraints governing datasource behavior. Prevents logic creep and enforces separation of concerns (e.g., "Datasource returns raw DTOs, does not parse to Domain Models").

4.5 Test Cases

Role:
Defines the minimum set of tests validating datasource behavior. Tests must align strictly with the Full Method Working section.

5. Repository (The Policy)

Focus: Coordination, Decision Making, and Data Flow.

5.1 Full Method Working (Plain English)

Role: Describes repository runtime behavior from entry to exit in natural language. Acts as the authoritative source for repository tests and implementation.

5.2 Context & Inputs

Role: Lists every external influence required by the Repository to decide and coordinate.

Includes:

Services: The Datasource instance defined above, Analytics services, Logging services, or Singletons.

Data: Arguments passed into the repository method from the domain/UI layer.

Constraint: The Repository cannot access low-level IO clients (e.g., HttpClient) directly; it must go through the Datasource context.

5.3 Edge Cases

Role:
Captures all decision-relevant and failure scenarios. Prevents hidden branches during implementation.

5.4 Architectural Decisions

Role:
Justifies why logic lives in the repository. Defines responsibility for routing, validation, transformation, and failure mapping.

5.5 Test Cases

Role:
Defines all repository-level tests derived from responsibilities and behavior. Every responsibility must be validated by at least one test.

6. Full Working Flow (Datasource → Repository)

Role:
Validates end-to-end behavior across layers before code exists.

Format:
Simple Plain English. Narrate the story of the data from the moment the user triggers the action until the result returns to the UI.

Step 1: The repository receives X...

Step 2: It calls the datasource...

Step 3: The datasource fetches...

Step 4: If successful, the repository transforms...

7. Notes

Role:
Records constraints, assumptions, and guardrails that should not live in code. Protects architectural intent over time.

