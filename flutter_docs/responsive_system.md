# Responsive System Architecture

The `core_ui_kit` provides a production-grade, "Scale-Ready" responsive architecture based on Material Design 3 specifications. It goes beyond simple media queries by offering a unified system for layout, typography, and generic value resolution.

---

## 📚 Table of Contents
1. [Setup (Mandatory)](#1-setup-mandatory)
2. [Foundations](#2-foundations)
    * [Window Size Classes](#window-size-classes)
    * [Breakpoints](#breakpoints)
3. [Responsive Widgets](#3-responsive-widgets)
...
---

## 1. Setup (Mandatory)

For the responsive system (especially typography auto-scaling) to work, your app **must** be wrapped in a `ScreenSizeDetector` (usually in `main.dart`) and the responsive `textTheme` must be injected into your `MaterialApp`.

```dart
// lib/main.dart
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1. Wrap entire app in ScreenSizeDetector to enable size tracking
    return ScreenSizeDetector(
      child: Builder(
        builder: (context) {
          // 2. Create the responsive tokens
          final responsiveTokens = ResponsiveTokens.m3();
          
          // 3. Resolve the TextTheme for the CURRENT screen size
          final textTheme = responsiveTokens.toTextTheme(context);

          // 4. Inject resolved TextTheme into MaterialApp
          return MaterialApp.router(
            theme: ThemeData(
              useMaterial3: true,
              textTheme: textTheme, // <--- Injection
            ),
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
```

---

## 2. Foundations


### Window Size Classes
The system categorizes all screen widths into 5 standardized buckets (`WindowSizeClass`).

| Class | Range (dp) | Typical Device |
| :--- | :--- | :--- |
| **Compact** | < 600 | Phones (Portrait) |
| **Medium** | 600 - 839 | Tablets (Portrait), Foldables |
| **Expanded** | 840 - 1199 | Tablets (Landscape), Small Laptops |
| **Large** | 1200 - 1535 | Laptops, Desktops |
| **ExtraLarge** | ≥ 1536 | Large Monitors, TVs |

### Breakpoints
The default breakpoints follow M3. You can customize them globally via `BreakpointConfiguration`.

```dart
// Customizing breakpoints (usually done in main.dart)
const customBreakpoints = BreakpointConfiguration(
  compact: 500,
  medium: 900,
  // ...
);
```

---

## 2. Responsive Widgets

### ScreenSizeDetector
**The Brain.** This widget must wrap your app to enable responsive features. It listens to `MediaQuery` changes efficiently (using `sizeOf` to prevent unnecessary rebuilds).

**Key Features:**
*   **Efficient:** Doesn't rebuild the tree if the *size* changes but the *class* stays the same (unless using `widthOf`).
*   **Static Access:** Access data anywhere via `ScreenSizeDetector.of(context)`.
*   **Progressive Checks:** `ScreenSizeDetector.isAtLeast(context, WindowSizeClass.expanded)`.

### ScreenSizeBuilder
**Global Layout Switcher.** Uses the **Screen Width** to decide what to render. Best for high-level structure (Scaffolds, Navigation).

```dart
ScreenSizeBuilder(
  builder: (context, windowClass) {
    if (windowClass.isDesktop) return SideNavLayout();
    return BottomNavLayout();
  },
)
```

### ResponsiveLayoutBuilder
**Component Layout Switcher.** Uses **Parent Constraint Width** to decide what to render. Best for reusable widgets (Cards, Grids).

```dart
// Even on a Desktop screen, if this widget is inside a 300px sidebar,
// windowClass will be 'Compact'.
ResponsiveLayoutBuilder(
  builder: (context, windowClass) {
    if (windowClass.isCompact) return VerticalList();
    return GridView();
  },
)
```

---

## 3. Responsive Values (Generic Responsiveness)

Do not limit responsiveness to just layout. Use `ResponsiveValue<T>` to make **any property** responsive (Padding, Colors, Icon Sizes, int, double, etc.).

### ResponsiveValue Usage
The generic class `ResponsiveValue<T>` allows you to define values for each class, with automatic fallback to smaller sizes.

```dart
// Define values once
final responsivePadding = ResponsiveValue<EdgeInsets>(
  compact: EdgeInsets.all(16),   // Mobile
  expanded: EdgeInsets.all(32),  // Tablet+
  // Large/ExtraLarge will fallback to 'expanded' (32)
);

// Resolve it in build()
Padding(
  padding: responsivePadding.resolve(context),
  child: ...
)
```

**Features:**
*   **Smart Fallback:** `large` falls back to `expanded` -> `medium` -> `compact`.
*   **`.map()`:** Transform values easily. `responsivePadding.map((p) => p.horizontal)`
*   **`.value`:** Access the raw `compact` value for static contexts.

---

## 4. Responsive Typography

The system solves the "Mobile vs Desktop" font size problem using `ResponsiveTextStyle` and `FontScalingConfiguration`. Text styles automatically scale based on the window size class. You don't need to manually adjust font sizes for desktop.

### Usage
Since the responsive theme is injected into `MaterialApp`, just use standard Flutter styles:

```dart
Text(
  'Auto-scaling Headline', 
  style: Theme.of(context).textTheme.headlineLarge,
);
```
*   **Mobile:** 32px
*   **Desktop:** ~39px (automatically scaled)

### Auto-Scaling Logic
Fonts are not static. They scale based on the `TypographyCategory` defined in `FontScalingConfiguration`:
*   **Display/Headline:** Scale aggressively (impactful).
*   **Body:** Scales conservatively (readability).
*   **Label:** Minimal/No scaling (UI consistency).

### Explicit Overrides
You can bypass auto-scaling for specific needs when defining custom styles:

```dart
// Option A: Auto-scaling (Standard)
final style = ResponsiveTextStyle(
  base: TextStyle(fontSize: 16),
  category: TypographyCategory.body, // Will scale ~10% on desktop
);

// Option B: Explicit (Pixel Perfect control)
final style = ResponsiveTextStyle.explicit(
  base: TextStyle(fontSize: 16),
  expanded: TextStyle(fontSize: 24), // Jump to 24px at 840dp
  large: TextStyle(fontSize: 32),    // Jump to 32px at 1200dp
);
```

---

## 5. API Reference & Extensions

The system adds powerful extensions to `BuildContext` and `WindowSizeClass` for cleaner code.

### WindowSizeClass Extensions
| Method | Description |
| :--- | :--- |
| `.isMobile` | True if Compact. |
| `.isTablet` | True if Medium or Expanded. |
| `.isDesktop` | True if Large or ExtraLarge. |
| `operator >=` | `class >= WindowSizeClass.expanded` (Great for progressive enhancement) |

### Context Extensions
| Method | Description |
| :--- | :--- |
| `context.isMobile` | Shortcut for `ScreenSizeDetector.isMobile(context)` |
| `context.windowSizeClass` | Get current class. |
| `context.screenWidth` | Get width (dp). |
| `context.screenHeight` | Get height (dp). |

### Comparison Example
**Old Way (Media Query):**
```dart
if (MediaQuery.of(context).size.width > 1200) { ... }
```

**New Way (Semantic):**
```dart
if (context.isDesktop) { ... }
// OR
if (ScreenSizeDetector.isAtLeast(context, WindowSizeClass.large)) { ... }
```

---

## 6. Cookbook & Examples

### A. Responsive Padding (using ResponsiveValue)
Make your page padding adapt to screen size.

```dart
class AdaptivePage extends StatelessWidget {
  // Define padding values
  static const _padding = ResponsiveValue<EdgeInsets>(
    compact: EdgeInsets.all(16),
    medium: EdgeInsets.all(24),
    large: EdgeInsets.all(40),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Resolve using context
      padding: _padding.resolve(context),
      child: Text('Content'),
    );
  }
}
```

### B. Adaptive Navigation (using ScreenSizeBuilder)
Switch between Bottom Bar and Navigation Rail.

```dart
class MainScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenSizeBuilder(
      builder: (context, windowClass) {
        // Desktop/Tablet: Row with Rail
        if (windowClass.isTablet || windowClass.isDesktop) {
          return Row(
            children: [
              NavigationRail(destinations: ...),
              Expanded(child: Body()),
            ],
          );
        }
        
        // Mobile: Column with Bottom Bar
        return Scaffold(
          body: Body(),
          bottomNavigationBar: BottomNavigationBar(items: ...),
        );
      },
    );
  }
}
```

### C. Responsive Grid Count (using ResponsiveValue)
Change the number of grid columns based on screen size.

```dart
class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 1 column on mobile, 2 on tablet, 4 on desktop
    final columnCount = ResponsiveValue<int>(
      compact: 1,
      medium: 2,
      expanded: 3,
      large: 4,
    ).resolve(context);

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCount,
      ),
      itemBuilder: ...
    );
  }
}
```

### D. Reusable Responsive Card (using ResponsiveLayoutBuilder)
A card that shows image on top (mobile) or left (desktop), regardless of screen size, based on its parent container.

```dart
class AdaptableCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Looks at PARENT width, not SCREEN width
    return ResponsiveLayoutBuilder(
      builder: (context, windowClass) {
        if (windowClass.isCompact) {
          // Narrow container: Stack vertically
          return Column(children: [Image(), Text()]);
        } else {
          // Wide container: Row
          return Row(children: [Image(), Expanded(child: Text())]);
        }
      },
    );
  }
}
```
