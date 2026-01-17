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
4. [Responsive Typography](#4-responsive-typography)
    * [ResponsiveTextStyle](#responsivetextstyle)
    * [ResponsiveTokens](#responsivetokens)
5. [Implementation Guide](#5-implementation-guide)

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

For responsive typography, you can also inject the responsive text theme.

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
          // 2. (Optional) Generate responsive text theme
          final responsiveTheme = ResponsiveTokens.m3().toTextTheme(context);
          
          return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,
              textTheme: responsiveTheme, // Auto-scaling text
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

---

## 4. Responsive Typography

The system solves the "Mobile vs Desktop" font size problem using `ResponsiveTextStyle` and `ResponsiveTokens`.

### ResponsiveTextStyle
A style that automatically scales based on the window size class.

```dart
final bodyStyle = ResponsiveTextStyle(
  base: TextStyle(fontSize: 16), // Mobile size
  // Automatically scales up ~10-20% on Tablet/Desktop
);

Text('Hello', style: bodyStyle.resolve(context));
```

### ResponsiveTokens
Provides all 15 Material Design 3 styles (Display, Headline, Body, etc.) pre-configured with auto-scaling.

**Usage with Extensions:**
If you set up `ResponsiveTypographyProvider` or inject it into `ThemeData`, you can use standard shortcuts:

```dart
// Standard Flutter way (if injected into Theme)
Text('Headline', style: Theme.of(context).textTheme.headlineLarge);

// Direct Extension way (if using ResponsiveTypographyProvider)
Text('Headline', style: context.headlineLarge);
```

---

## 5. Implementation Guide

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
