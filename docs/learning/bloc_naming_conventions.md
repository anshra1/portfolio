# Bloc Naming Conventions

This document outlines the strict naming standards for the Bloc library in this project, separated by usage and intent.

---

## 1. Events (UI $\rightarrow$ Bloc)
Events represent something that **already happened** in the UI or system.

*   **Rule**: Must be in **Past Tense** AND end with the suffix `Event`.
*   **Syntax**: `[Subject] + [Action (Verb)] + [Context] + Event`
*   **Examples**:
    *   ✅ `CounterIncrementPressedEvent`
    *   ✅ `ThemeToggleToggledEvent`
    *   ✅ `SettingsLoadRequestedEvent`
    *   ❌ `CounterIncrementPressed` (Missing suffix)
    *   ❌ `IncrementCounterEvent` (Imperative)

---

## 2. States (Bloc $\rightarrow$ UI)
States represent a **snapshot** or a **condition** of the system at a specific moment. We use **Sealed Classes** (separate classes), not one big class.

*   **Rule**: Must be **Nouns** AND end with the suffix `State`.
*   **Syntax**: `[Subject] + [Status] + State`
*   **Examples**:
    *   ✅ `AuthAuthenticatedState`
    *   ✅ `DataLoadInProgressState`
    *   ✅ `SearchEmptyState`
    *   ❌ `AuthAuthenticated` (Missing suffix)
    *   ❌ `LoadingState` (Too generic, needs Subject)

---

## 3. Cubit Methods (Imperative Actions)
Unlike Bloc events, Cubit methods are direct function calls.

*   **Rule**: Use **Imperative Verbs**.
*   **Syntax**: `[Verb] + [Noun]`
*   **Examples**:
    *   ✅ `increment()`
    *   ✅ `toggleTheme()`
    *   ✅ `fetchUserProfile()`

---

## 4. File Naming
*   **Bloc**: `feature_name_bloc.dart`
*   **Event**: `feature_name_event.dart`
*   **State**: `feature_name_state.dart`
*   **Cubit**: `feature_name_cubit.dart`
