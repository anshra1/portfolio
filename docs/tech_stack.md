# Technical Context: Flutter Project Environment

This document defines the technical boundaries and stack of the project. **AI agents MUST verify these constraints** before suggesting packages or writing platform-specific code.

---

## 1. Core Stack Versions
*   **Flutter SDK**: `^3.x.x` (Stable)
*   **Dart SDK**: `^3.9.2` (Strict Null Safety)
*   **Platforms Supported**:
    *   ✅ **Web**
    *   ❌ Android (Not initialized)
    *   ❌ iOS (Not initialized)

---

## 2. Primary Dependencies (The "Source of Truth")
AI should prioritize using these existing packages over introducing new ones.

### **State Management & Logic**
*   **`bloc`**: ` (Core state management logic).
*   **`equatable`**:` (Via `core_ui_kit` - For value equality).
*   *Note*: `flutter_bloc` is mandated by `system_patterns.md` but is currently missing from `pubspec.yaml`.

### **Navigation & Routing**
*   **`go_router`**: `^17.0.1` (Deep-linking and navigation logic).

### **Dependency Injection**
*   **`flutter_getit`**: `^3.0.1` (Service locator wrapper).

### **UI & Assets**
*   **`core_ui_kit`**: Local package (Custom UI components).
*   **`cupertino_icons`**: `^1.0.8`.
*   **`flutter_gen`**: `^5.12.0` (Asset generation).

---

## 3. Environment & Configuration
*   **Flavoring**: Not yet configured.
*   **API Base URL**: TBD.
*   **Auth Strategy**: TBD.

---

## 4. Development Tools & CI/CD
*   **Linting**:
    *   `very_good_analysis`: `^10.0.0` (Strict rules).
    *   `flutter_lints`: `^5.0.0`.
*   **Testing**:
    *   `flutter_test`
*   **Code Generation**:
    *   Command: `dart run build_runner build --delete-conflicting-outputs`

---

## 5. Known Constraints & Technical Debt
1.  **Missing `flutter_bloc`**: The system patterns require `flutter_bloc`, but it is not listed in `pubspec.yaml`.
2.  **Mobile Platforms**: Android and iOS directories are missing; currently a Web-only structure.
