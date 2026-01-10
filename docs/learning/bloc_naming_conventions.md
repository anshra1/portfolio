# Bloc Naming Conventions

This document outlines the strict naming standards for the Bloc library in this project, separated by usage and intent.

---

## 1. Events (UI $\rightarrow$ Bloc)
Events represent something that **already happened** in the UI or system.

*   **Rule**: Must be in **Past Tense**.
*   **Syntax**: `[Subject] + [Action (Verb)] + [Context/Suffix]`
*   **Examples**:
    *   ✅ `CounterIncrementPressed`
    *   ✅ `ThemeToggleToggled`
    *   ✅ `SettingsLoadRequested`
    *   ❌ `IncrementCounter` (Imperative)
    *   ❌ `LoadSettings` (Command)

---

## 2. States (Bloc $\rightarrow$ UI)
States represent a **snapshot** or a **condition** of the system at a specific moment.

*   **Rule**: Must be **Nouns** or **Adjectives describing a status**.
*   **Syntax**: `[Subject] + [Status/Description]`
*   **Examples**:
    *   ✅ `AuthAuthenticated`
    *   ✅ `DataLoadInProgress`
    *   ✅ `SearchEmpty`
    *   ❌ `Loading` (Too generic)
    *   ❌ `Loaded` (Ambiguous)

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
