### **Presentation Layer (Outer)**
*Handles UI and State Management.*
*   **BLoCs**: Manage state transitions.
    *   *Rule*: **No business logic**. BLoCs only call Use Cases.
*   **Pages**: Top-level widgets linked to a BLoC.
*   **Widgets**: Reusable UI components.

## 2. BLoC Pattern Standards
We follow a strict **Event-State** flow to prevent UI bloat.

*   **State Composition**: Every BLoC state **MUST** be a single class using `freezed` (preferred) or `Equatable`.
    *   *Standard Sub-states*: `initial`, `loading`, `loaded`, `error`.
*   **Event Naming**: `[Feature][Subject][Verb]`
    *   *Examples*: `AuthLoginStarted`, `CartItemRemoved`.
*   **Logic Placement**:
    *   BLoCs must **only** call Use Cases.
    *   **NEVER** perform direct repository calls or complex business logic inside the BLoC.

---

### **Widget Consistency**
*   **Complex UI**: Use `_build[ElementName]` methods to keep the main `build` method clean.
*   **Strings**: **No hardcoded strings**. Use the `S.of(context)` (Intl) pattern.
*   **Colors**: **No hardcoded colors**. Use `Theme.of(context).colorScheme`.
*   **Async UI**: Use `BlocConsumer` or `BlocBuilder`.
    *   *Rule*: Always handle the `loading` state with a specific UI indicator.