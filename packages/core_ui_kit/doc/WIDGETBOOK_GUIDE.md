# Widgetbook Guide for Core UI Kit

This guide explains how to run, use, and extend **Widgetbook** for the `core_ui_kit` package. Widgetbook is used to test, document, and showcase our UI components in isolation.

## 1. Setup & Architecture

Widgetbook is implemented in the `example` project of the `core_ui_kit` package to avoid polluting the main package dependencies.

- **Location:** `packages/core_ui_kit/example/lib/widgetbook.dart`
- **Stories:** `packages/core_ui_kit/example/lib/stories/`
- **Generated Code:** `packages/core_ui_kit/example/lib/widgetbook.directories.g.dart`

## 2. Running Widgetbook

### Option A: Web Server (Recommended)
This method is most reliable for local development as it avoids browser launch issues.

1.  Navigate to the example directory:
    ```bash
    cd packages/core_ui_kit/example
    ```

2.  Run in web-server mode:
    ```bash
    flutter run -d web-server --web-port 8080 -t lib/widgetbook.dart
    ```

3.  Open your browser and visit:
    **http://localhost:8080**

### Option B: Desktop (Linux/macOS/Windows)
To run as a native application:

```bash
cd packages/core_ui_kit/example
flutter run -d linux -t lib/widgetbook.dart
# Replace 'linux' with 'macos' or 'windows' as needed.
```

## 3. Adding New Stories

To add a new component to Widgetbook, follow these steps:

1.  **Create a Story File:**
    Create a new file in `packages/core_ui_kit/example/lib/stories/` named after your component (e.g., `card_stories.dart`).

2.  **Add Use Cases:**
    Import your component and `widgetbook_annotation`, then define your stories using the `@UseCase` annotation.

    ```dart
    import 'package:flutter/material.dart';
    import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
    import 'package:core_ui_kit/core_ui_kit.dart';

    @widgetbook.UseCase(
      name: 'Default',
      type: YourComponent,
    )
    Widget yourComponentDefault(BuildContext context) {
      return Center(
        child: YourComponent(
          title: 'Hello World',
        ),
      );
    }
    ```

3.  **Regenerate Code:**
    Widgetbook relies on code generation. You **must** run this command after adding or modifying annotations:

    ```bash
    cd packages/core_ui_kit/example
    dart run build_runner build --delete-conflicting-outputs
    ```

## 4. Troubleshooting common issues

### "Target of URI doesn't exist"
If you see errors about missing `widgetbook.directories.g.dart`:
- Run the **Regenerate Code** command listed above.

### "Waiting for connection..." hangs
- Use **Option A (Web Server)**.
- Check if port `8080` is already in use. You can change it with `--web-port 8081`.

### Updates not showing?
- Widgetbook uses code generation. Did you remember to run `build_runner`?
- Hot restart (`r` or `R` in terminal) is usually sufficient, but sometimes a full restart is needed after generation.
