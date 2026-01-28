# Responsive System Architecture

The `core_ui_kit` provides a production-grade, "Scale-Ready" responsive architecture based on Material Design 3 specifications. It differentiates between global layout decisions (based on device screen) and local component decisions (based on available parent space).

---

## 📚 Table of Contents
1. [Core Concepts](#1-core-concepts-context-vs-constraints)
2. [Setup](#2-setup-mandatory)
3. [Tools & Widgets](#3-tools--widgets)
    * [ScreenSizeDetector](#screensizedetector)
    * [ScreenSizeBuilder](#screensizebuilder-global)
    * [ResponsiveLayoutBuilder](#responsivelayoutbuilder-local)
4. [Implementation Guide](#4-implementation-guide)

---

## 1. Core Concepts: Context vs. Constraints

The system distinguishes between two types of responsiveness:

| Concept | Source | Tool | Use Case |
| :--- | :--- | :--- | :--- |
| **Global Context** | **Screen Width** (`MediaQuery`) | `ScreenSizeBuilder` | Determining Navigation (Rail vs BottomBar), Page Structure (Master-Detail vs List), showing/hiding global drawers. |
| **Local Constraints** | **Parent Width** (`LayoutBuilder`) | `ResponsiveLayoutBuilder` | Reusable components (Cards, List Items) that need to adapt whether they are full-screen or inside a sidebar. |

---

## 2. Setup (Mandatory)

To enable the responsive system, wrap your application in a `ScreenSizeDetector`. This is typically done in `main.dart`.



```dart
// lib/main.dart
import 'package:core_ui_kit/core_ui_kit.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Wrap app in ScreenSizeDetector
    return ScreenSizeDetector(
      child: Builder(
        builder: (context) {

          
          return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,

            ),
            // ... router config
          );
        },
      ),
    );
  }
}
```

---

## 3. Tools & Widgets

### ScreenSizeDetector
The "Brain" of the operation. It listens to screen size changes and exposes the `WindowSizeClass` to the widget tree.

*   **Access:** `ScreenSizeDetector.of(context)` or `context.windowSizeClass`.
*   **Helpers:** `context.isMobile`, `context.isTablet`, `context.isDesktop`.

### ScreenSizeBuilder (Global)
Use this for **high-level layout switching** based on the device type.

**Example: Switching Page Layouts**
```dart
// lib/features/homepage/home_page.dart
class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenSizeBuilder(
      builder: (context, size) {
        if (size.isDesktop) return const HomePageWeb(); // Sidebar Layout
        if (size.isTablet) return const HomePageTablet(); // Hybrid Layout
        return const HomePageMobile(); // BottomNav Layout
      },
    );
  }
}
```

### ResponsiveLayoutBuilder (Local)
Use this for **adaptive components**. It allows a widget to look "Mobile" (compact) even when running on a Desktop, if it's placed inside a narrow container (like a sidebar).

**Example: Adaptive User Card**
```dart
class AdaptiveUserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Adapts to parent width, not screen width
    return ResponsiveLayoutBuilder(
      builder: (context, sizeClass) {
        if (sizeClass.isCompact) {
          return Column(children: [Avatar(), Name()]); // Vertical stack
        } else {
          return Row(children: [Avatar(), Name()]);    // Horizontal row
        }
      },
    );
  }
}
```

### ResponsiveValue (Generic)
A utility to change *values* (padding, numbers, strings, etc.) based on screen size without if/else logic. It features intelligent fallback (e.g., `large` falls back to `expanded` if undefined).

**Example: Responsive Padding**
```dart
final padding = ResponsiveValue<EdgeInsets>(
  compact: EdgeInsets.all(16),  // Mobile
  medium: EdgeInsets.all(24),   // Tablet
  large: EdgeInsets.all(32),    // Desktop
).resolve(context);

return Container(padding: padding, ...);
```

---

## 4. Implementation Guide

### Folder Structure Pattern
For major features, separate layouts into dedicated files to keep code clean.

```
lib/features/homepage/
├── home_page.dart        // The Switcher (uses ScreenSizeBuilder)
├── home_page_mobile.dart // Mobile implementation
├── home_page_tablet.dart // Tablet implementation
└── home_page_web.dart    // Desktop/Web implementation
```

### Window Size Classes (Material Design 3)

| Class | Range (dp) | Logic |
| :--- | :--- | :--- |
| **Compact** | < 600 | `isMobile` |
| **Medium** | 600 - 839 | `isTablet` |
| **Expanded** | 840 - 1199 | `isTablet` |
| **Large** | 1200 - 1535 | `isDesktop` |
| **ExtraLarge** | ≥ 1536 | `isDesktop` |
