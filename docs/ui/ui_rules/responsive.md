# Responsive Design Rules

> **Core Principle**: Responsive layout changes structure at specific breakpoints. Mobile ≠ scaled desktop.

---

## Table of Contents

1. [What is Responsive Layout](#what-is-responsive-layout)
2. [Responsive vs Fluid vs Adaptive](#responsive-vs-fluid-vs-adaptive)
3. [Implementation in Flutter](#implementation-in-flutter)
4. [Responsive Architecture](#responsive-architecture)
5. [Design Principles](#design-principles)
6. [Decision Guide](#decision-guide)
7. [Quick Reference](#quick-reference)

---

## What is Responsive Layout

A responsive layout **changes its structure at specific breakpoints**.

### Breakpoint Behavior

The UI **jumps** between predefined designs:

| Breakpoint | Width Range | Layout Type |
|------------|-------------|-------------|
| Mobile | < 600px | Single column, stacked |
| Tablet | 600px - 1024px | Two columns or grid |
| Desktop | ≥ 1024px | Multi-column or complex grid |

**Example**:
```dart
// At 599px: Single column mobile layout
// At 600px: Switches to two-column tablet layout
// At 1024px: Switches to three-column desktop layout
```

### Key Characteristics

- ✅ Discrete layout changes at breakpoints
- ✅ Different structure for different screen sizes
- ✅ Same components, different arrangements
- ✅ Optimized for specific device categories

---

## Responsive vs Fluid vs Adaptive

Understanding the differences:

### 1. Responsive Layout

**What it is**: Layout structure changes at specific breakpoints.

**Examples**:
- 1 column → 2 columns → 3 columns
- Vertical stack → horizontal grid
- Sidebar hidden → sidebar visible

**Flutter implementation**: `LayoutBuilder`, `MediaQuery`, breakpoint switching

```dart
ResponsiveLayout(
  mobile: SingleColumnLayout(),
  tablet: TwoColumnLayout(),
  desktop: ThreeColumnLayout(),
)
```

---

### 2. Fluid Layout

**What it is**: Continuous resizing without breakpoints.

**Examples**:
- Components grow/shrink smoothly
- Consistent proportions at all sizes
- No sudden jumps

**Flutter implementation**: `Expanded`, `Flexible`, `FractionallySizedBox`

```dart
Row(
  children: [
    Expanded(flex: 2, child: MainContent()),
    Expanded(flex: 1, child: Sidebar()),
  ],
)
```

---

### 3. Adaptive Layout

**What it is**: Changes based on platform/input method, not just screen size.

**Examples**:
- Touch vs mouse interactions
- Material (Android) vs Cupertino (iOS) widgets
- Web vs mobile navigation patterns

**Flutter implementation**: Platform detection, `kIsWeb`, pointer detection

```dart
Platform.isIOS 
  ? CupertinoButton(...)
  : ElevatedButton(...)
```

---

## Implementation in Flutter

### Flutter Tools Mapping

| Goal | Flutter Tool |
|------|--------------|
| **Breakpoints** | `MediaQuery.of(context).size.width`, `LayoutBuilder` |
| **Fluid resizing** | `Flex`, `Expanded`, `Flexible`, `constraints` |
| **Adaptive behavior** | `kIsWeb`, `Platform.isIOS`, pointer detection |
| **Multi-layout** | `ResponsiveBuilder` patterns, custom layout switchers |

### Basic Implementation Pattern

```dart
class ResponsiveLayout extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveLayout({
    super.key,
    required this.mobile,
    this.tablet,
    required this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Mobile: < 600px
        if (width < 600) return mobile;
        
        // Tablet: 600px - 1024px
        if (width < 1024) return tablet ?? mobile;
        
        // Desktop: ≥ 1024px
        return desktop;
      },
    );
  }
}
```

---

## Responsive Architecture

### Information Flow

```
Route (HomePage)
    ↓
Layout Selector (based on width)
    ↓
Structural Layout (mobile/tablet/desktop)
    ↓
Reusable Components (size-agnostic)
```

### Architecture Rules

**You should have**:

- ✅ Different layouts for different breakpoints
- ✅ Same components across all layouts
- ✅ Same business logic across all layouts
- ✅ Same route for all layouts
- ✅ Same state management across all layouts

**You should NOT have**:

- ❌ Behavior decided by layout
- ❌ Business logic inside layout widgets
- ❌ Different components for different breakpoints
- ❌ Separate routes for mobile/desktop

### Example

**✅ Correct**:
```dart
// Same route, same state, different layouts
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: ResponsiveLayout(
        mobile: HomeMobileLayout(),
        tablet: HomeTabletLayout(),
        desktop: HomeDesktopLayout(),
      ),
    );
  }
}

// Same component used in all layouts
class ProjectCard extends StatelessWidget {
  final Project project;
  
  const ProjectCard({required this.project});
  
  @override
  Widget build(BuildContext context) {
    // Size-agnostic component
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text(project.title),
          Text(project.description),
        ],
      ),
    );
  }
}
```

**❌ Wrong**:
```dart
// Different components for different breakpoints
class MobileProjectCard extends StatelessWidget { ... }
class DesktopProjectCard extends StatelessWidget { ... }

// Behavior decided by layout
class ProjectLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          // ❌ Business logic in layout
          context.read<ProjectBloc>().add(LoadMobileProjects());
        }
        return ...;
      },
    );
  }
}
```

---

## Design Principles

### Principle 1: Mobile ≠ Scaled Desktop

Mobile layouts are not just smaller versions of desktop layouts.

**❌ Wrong approach**:
```dart
// Just scaling everything down
Transform.scale(
  scale: isMobile ? 0.5 : 1.0,
  child: DesktopLayout(),
)
```

**✅ Correct approach**:
```dart
// Different structure for mobile
ResponsiveLayout(
  mobile: Column(children: [A, B, C]),      // Vertical stack
  desktop: Row(children: [A, Expanded(child: Column(children: [B, C]))]), // Sidebar + content
)
```

---

### Principle 2: Desktop ≠ Stretched Mobile

Desktop layouts should use available space effectively, not just stretch mobile components.

**❌ Wrong**:
```dart
// Mobile layout with max width
Center(
  child: SizedBox(
    width: double.infinity, // Stretches to full width on desktop
    child: MobileColumn(),
  ),
)
```

**✅ Correct**:
```dart
// Desktop uses multi-column layout
ResponsiveLayout(
  mobile: SingleColumnLayout(),
  desktop: ThreeColumnLayout(), // Utilizes screen space
)
```

---

### Principle 3: Structure Must Change

Different breakpoints should have different **structural** layouts.

**Examples**:
- Mobile: Vertical stack
- Tablet: 2-column grid
- Desktop: 3-column grid + sidebar

**Code**:
```dart
ResponsiveLayout(
  mobile: Column(children: items),
  tablet: GridView.count(crossAxisCount: 2, children: items),
  desktop: Row(
    children: [
      Sidebar(),
      Expanded(
        child: GridView.count(crossAxisCount: 3, children: items),
      ),
    ],
  ),
)
```

---

### Principle 4: Density Must Change

Content density should adapt to screen size.

| Breakpoint | Density | Spacing | Font Size |
|------------|---------|---------|-----------|
| Mobile | Low | Compact | Smaller |
| Tablet | Medium | Comfortable | Medium |
| Desktop | High | Spacious | Larger |

**Example**:
```dart
ResponsiveLayout(
  mobile: GridView.count(
    crossAxisCount: 1,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
  ),
  desktop: GridView.count(
    crossAxisCount: 3,
    mainAxisSpacing: 24,
    crossAxisSpacing: 24,
  ),
)
```

---

### Principle 5: Interaction Model Must Adapt

Different devices have different interaction patterns.

| Device | Input | Interaction Pattern |
|--------|-------|---------------------|
| Mobile | Touch | Large tap targets, swipe gestures |
| Tablet | Touch/Stylus | Medium targets, multi-touch |
| Desktop | Mouse/Keyboard | Hover states, keyboard shortcuts |

**Example**:
```dart
// Mobile: Bottom sheet
showModalBottomSheet(context: context, builder: (_) => FilterSheet());

// Desktop: Dropdown menu
PopupMenuButton(items: filterItems);
```

---

### Principle 6: Content Must Not Be Hidden Without Reason

Don't arbitrarily hide content on smaller screens.

**❌ Wrong**:
```dart
if (!isMobile) {
  // ❌ Hiding important content on mobile
  return ImportantFeature();
}
```

**✅ Correct**:
```dart
// Reorganize, don't hide
ResponsiveLayout(
  mobile: Column(children: [Feature1, Feature2, Feature3]),
  desktop: Row(children: [Feature1, Column(children: [Feature2, Feature3])]),
)
```

---

### Principle 7: Important Content Must Remain Visible

Critical information should be accessible on all screen sizes.

**✅ Correct**:
```dart
// Important CTA visible on all breakpoints
ResponsiveLayout(
  mobile: Column(
    children: [
      ContentSection(),
      CTAButton(), // Still visible
    ],
  ),
  desktop: Row(
    children: [
      Expanded(child: ContentSection()),
      CTAButton(), // Still visible
    ],
  ),
)
```

---

### Principle 8: UI Must Survive Resizing

The UI should handle window resizing gracefully.

**Test your UI**:
- Resize browser window from mobile to desktop width
- App should smoothly transition between layouts
- No overflow errors
- No content cutoff

---

### Principle 9: UI Must Survive Zooming

The UI should remain functional when users zoom in/out.

**Guidelines**:
- Use relative sizing (`Expanded`, `Flexible`)
- Avoid absolute pixel values where possible
- Test with browser zoom at 50%, 100%, 200%

---

### Principle 10: UI Must Survive Split Screen

The UI should work in split-screen mode on tablets and desktops.

**Test scenarios**:
- iPad split screen (50/50, 25/75)
- Windows snap (50% window width)
- Android multi-window

**Example**:
```dart
// Gracefully falls back to mobile layout in split screen
ResponsiveLayout(
  mobile: MobileLayout(),      // Used in split screen
  tablet: TabletLayout(),       // Used in full screen tablet
  desktop: DesktopLayout(),     // Used in full screen desktop
)
```

---

## Decision Guide

Choose the right approach based on your app type:

### Question 1: Is this a content site?

**Yes** → **Responsive-first**

Content sites benefit from layout changes at breakpoints.

**Examples**: Blogs, portfolios, marketing sites

**Implementation**:
```dart
ResponsiveLayout(
  mobile: ArticleStackLayout(),
  tablet: ArticleTwoColumnLayout(),
  desktop: ArticleThreeColumnLayout(),
)
```

---

### Question 2: Is this a tool/dashboard?

**Yes** → **Fluid-first**

Tools and dashboards benefit from continuous resizing.

**Examples**: Admin panels, data dashboards, productivity tools

**Implementation**:
```dart
Row(
  children: [
    Expanded(flex: 2, child: MainPanel()),
    Expanded(flex: 1, child: SidePanel()),
  ],
)
```

---

### Question 3: Is this cross-platform?

**Yes** → **Adaptive required**

Cross-platform apps need platform-specific adaptations.

**Examples**: Apps targeting iOS, Android, and Web

**Implementation**:
```dart
Platform.isIOS
  ? CupertinoPageScaffold(...)
  : Scaffold(...)
```

---

## Quick Reference

### Responsive Design Checklist

When implementing responsive design:

- [ ] Defined breakpoints (mobile, tablet, desktop)
- [ ] Created separate layout widgets for each breakpoint
- [ ] Same components used across all layouts
- [ ] Same business logic across all layouts
- [ ] Same state management across all layouts
- [ ] Structure changes between breakpoints
- [ ] Density changes between breakpoints
- [ ] No content hidden without reason
- [ ] Important content visible on all breakpoints
- [ ] UI tested with window resizing
- [ ] UI tested with browser zoom
- [ ] UI tested with split screen
- [ ] Mobile is not just scaled desktop
- [ ] Desktop utilizes available space effectively

### Common Breakpoints

| Breakpoint | Width | Device Examples |
|------------|-------|-----------------|
| Small Mobile | < 360px | iPhone SE, small Android phones |
| Mobile | 360px - 599px | iPhone, standard Android phones |
| Tablet | 600px - 1023px | iPad, Android tablets |
| Desktop | 1024px - 1439px | Laptop, small desktop |
| Large Desktop | ≥ 1440px | Large monitors, 4K displays |

### Responsive Layout Patterns

#### Pattern 1: Column → Grid

```dart
ResponsiveLayout(
  mobile: Column(children: items),
  tablet: GridView.count(crossAxisCount: 2, children: items),
  desktop: GridView.count(crossAxisCount: 4, children: items),
)
```

#### Pattern 2: Stack → Sidebar

```dart
ResponsiveLayout(
  mobile: Column(children: [content, sidebar]),
  desktop: Row(children: [Expanded(child: content), SizedBox(width: 300, child: sidebar)]),
)
```

#### Pattern 3: Bottom Nav → Side Nav

```dart
ResponsiveLayout(
  mobile: Scaffold(
    body: content,
    bottomNavigationBar: BottomNavBar(),
  ),
  desktop: Row(
    children: [
      SideNavBar(),
      Expanded(child: content),
    ],
  ),
)
```

---

**Remember**: Responsive = Structure changes at breakpoints. Fluid = Continuous resizing. Adaptive = Platform-specific behavior.