## 5. Testing Rules

### 5.1 Use Case Tests

* Mandatory for every use case
* Test success and failure paths

### 5.2 Repository Tests

* Required only if repository contains logic
* Pure delegation repositories do not need tests

### 5.3 Data Source Tests

* Optional
* Usually covered by integration tests

---

## 6. Error Handling Pattern

* Data layer throws Exceptions
* Repository maps Exceptions → Failures
* Domain and UI never see Exceptions

---

## 6. Testing Philosophy
AI **MUST** follow these rules when generating tests:

*   **Unit Tests**: **Mandatory** for Use Cases and BLoCs. Use the `bloc_test` package.
*   **Mocks**: Use `mocktail` for mocking dependencies.
*   **Contract**: Every BLoC test must verify that `loading` is emitted **before** `loaded` or `error`.

---