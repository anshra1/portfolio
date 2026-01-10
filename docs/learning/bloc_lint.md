# Bloc Lint: Official Reference & Guide

This document is a comprehensive conversion of the official Bloc Linter documentation, adapted for our project.

---

## 1. Overview
Linting statically analyzes code for potential bugs and stylistic errors without executing a single line of code. The **Bloc Linter** enforces architectural consistency and decouples your business logic from Flutter.

### The "Golden Rule"
**Avoid importing Flutter within bloc instances.** Blocs should be decoupled from the UI framework to remain testable and portable.

---

## 2. Installation

### Command-Line Tools
To use the linter from your terminal, install the global tools:
```bash
dart pub global activate bloc_tools
```

### Project Package
Add the linter as a development dependency:
```bash
dart pub add --dev bloc_lint
```

---

## 3. Configuration Styles

You have several ways to configure the linter in `analysis_options.yaml`.

### Method A: Multiple Includes (Modern Standard)
Dart supports including multiple rule sets. The last one in the list takes precedence for overrides.
```yaml
include:
  - package:very_good_analysis/analysis_options.yaml
  - package:bloc_lint/recommended.yaml
```

### Method B: Manual / Granular Control (Project Standard)
We strictly use this method to have **explicit visibility** of active rules. This configuration serves as the source of truth for our architectural standards.

**Our Official Configuration:**
```yaml
# 1. Include your base linter (General Code Quality)
include: package:very_good_analysis/analysis_options.yaml

# 2. Enable Bloc rules explicitly (Architectural Safety)
bloc:
  rules:
    # 🛡️ ARCHITECTURE SAFETY (Critical)
    - avoid_flutter_imports                  # CRITICAL: No UI in Logic
    - avoid_public_fields                    # CRITICAL: Immutable State
    - avoid_public_properties_in_bloc_and_cubit
    - prefer_bloc_in_provider                # Safe Lifecycle
    
    # 📝 NAMING & STYLE (Consistency)
    - prefer_file_naming_conventions         # Enforces _bloc.dart, _event.dart
    - avoid_public_bloc_methods              # Force Event-Driven Architecture
    - prefer_void_public_cubit_methods       # Cubit methods should be one-way (void)
    
    # 🔌 USAGE PATTERNS
    - avoid_build_context_extensions         # Don't use context.read inside BLoC
    - prefer_build_context_extensions        # Do use context.read inside UI

# 3. Custom Lint Plugin (Required for IDE Red/Yellow Lines)
analyzer:
  plugins:
    - custom_lint
```

#### Why we DISABLED some rules
We intentionally **do not** include:
*   `prefer_bloc`: Forbidden because we want the freedom to use `Cubit` for simple states.
*   `prefer_cubit`: Forbidden because we want the freedom to use `Bloc` for complex event flows.

We adopt a **"Balanced"** approach: Strict on safety/immutability, flexible on tool choice.

---

## 4. Customizing Rule Severity

You can adjust the severity of any rule to match your project's strictness:

```yaml
bloc:
  rules:
    avoid_flutter_imports: info # Change from warning to info
```

### Supported Severity Levels
| Severity | Description |
| :--- | :--- |
| **error** | Indicates the pattern is strictly not allowed. |
| **warning** | Indicates the pattern is suspicious but allowed. |
| **info** | Provides information to users but is not a problem. |
| **hint** | Proposes a better way of achieving a result. |

---

## 5. Excluding Files

Just like standard Dart lints, you can exclude files or patterns from analysis:

```yaml
analyzer:
  exclude:
    - "**.g.dart" # Exclude all generated code
    - "lib/legacy/**"
```

---

## 6. Ignoring Rules (In-Code)

If you need to bypass a rule for a specific line or file, use ignore comments.

### Ignoring Lines
Place the comment above or at the end of the line:
```dart
// ignore: prefer_file_naming_conventions
class My_Bloc extends Bloc { ... }

class AnotherBloc extends Bloc { ... } // ignore: prefer_file_naming_conventions
```

### Ignoring Files
Add the comment at the very top of the file:
```dart
// ignore_for_file: prefer_file_naming_conventions
import 'package:bloc/bloc.dart';
```

---

## 7. Complete List of Rules

| Rule | Purpose |
| :--- | :--- |
| **avoid_flutter_imports** | Prevents `material.dart` etc. inside Blocs/Cubits. |
| **avoid_build_context_extensions** | Prevents using `context.read<T>()` inside Bloc files. |
| **avoid_public_bloc_methods** | Blocs should use events, not public methods (use Cubits for methods). |
| **avoid_public_fields** | Ensures state is immutable (prevents data corruption). |
| **prefer_bloc** | Enforces the use of `Bloc` over `Cubit` (if desired). |
| **prefer_cubit** | Enforces the use of `Cubit` over `Bloc` (if desired). |
| **prefer_build_context_extensions** | Encourages `context.read/watch` in the UI layer. |
| **prefer_file_naming_conventions** | Enforces `_bloc.dart`, `_event.dart`, `_state.dart`. |
| **prefer_void_public_cubit_methods** | Cubit methods should not return values (use states instead). |

---

## 8. Usage Commands

- **Audit all files:** `bloc lint .`
- **Audit specific folders:** `bloc lint lib/ test/`
- **Help:** `bloc lint --help`

---

## 9. IDE Integration

- **VS Code:** Requires the `Bloc` extension (v6.8.0+).
- **IntelliJ:** Requires the `Bloc` plugin (v4.1.0+).
- **Benefit:** Warnings appear directly in the "Problems" tab as you type.
