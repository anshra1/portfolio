# View Design Rules

> **Core Principle**: A view is a state projection layer that bridges logic state with UI components. Views listen to state and compose components, but do not define layout or styling.

---

## Widget System Mapping

The **`_view`** suffix from the [Widget Naming System](../widget_naming_system.md) represents **State-Driven Widgets** that **MUST** follow all rules in this document.

| Widget Category | Suffix | Purpose |
|----------------|--------|---------|
| **State-Driven Widget** | `_view` | Listens to state via BlocBuilder/Consumer, projects state to UI components |

**NOT views** (follow different rules):
- ❌ `_unit`, `_action`, `_control`, `_input`, `_visual` - Pure components (follow [Component Rules](component.md))
- ❌ `_layout` - Responsive layouts (follow [Layout Rules](layout.md))
- ❌ `_page` - Screen entry points (follow [Page Rules](page.md))

---

## Table of Contents

1. [View Responsibilities](#view-responsibilities)
2. [Core Design Rules](#core-design-rules)
3. [State Listening Patterns](#state-listening-patterns)
4. [Component Composition](#component-composition)
5. [View Validation Checklist](#view-validation-checklist)

---

## View Responsibilities

### What a View SHOULD Do

- ✅ Listen to logic state (BlocBuilder, Consumer, Selector)
- ✅ Conditional rendering based on state
- ✅ List building (ListView.builder, GridView.builder)
- ✅ Compose `_unit`, `_visual`, `_action`, `_control`, `_input` components
- ✅ Handle loading, error, and empty states
- ✅ Convert domain entities to ViewModels
- ✅ Accept minimal route/ID parameters

### What a View MUST NOT Do

- ❌ Define layouts (width, height, breakpoints)
- ❌ Use MediaQuery for sizing
- ❌ Use LayoutBuilder for responsive logic
- ❌ Control external spacing/margins
- ❌ Nest other `_view` widgets (keep hierarchy flat)
- ❌ Contain business logic
- ❌ Use local state (`setState`)
- ❌ Own controllers (that's `_input`)
- ❌ Accept callbacks as parameters (use slot pattern or compose `_action` directly)

---

## Core Design Rules

### Rule 1: Views Are State Projectors

A view's primary job is to **project state into UI structure**.

**✅ Correct:**
```dart
class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        if (state.isLoading) {
          return CircularProgressIndicator();
        }
        
        if (state.orders.isEmpty) {
          return EmptyOrdersVisual();
        }
        
        return ListView.builder(
          itemCount: state.orders.length,
          itemBuilder: (context, index) {
            final orderVM = OrderViewModel.fromDomain(state.orders[index]);
            return OrderCardUnit(
              viewModel: orderVM,
              actionSlot: OrderDetailsAction(orderId: orderVM.orderId),
            );
          },
        );
      },
    );
  }
}
```

**❌ Wrong:**
```dart
// View with layout logic
class OrdersListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
        return LayoutBuilder( // ❌ Layout logic in view
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
            return GridView.builder(...); // ❌ This should be in _layout
          },
        );
      },
    );
  }
}
```

---

### Rule 2: Views Must Be Stateless

Views should never use `setState` or local state mutations.

**✅ Allowed:**
- `StatelessWidget` only
- Listen to external state (BLoC, Provider, etc.)

**❌ Forbidden:**
- `StatefulWidget` with local state
- `setState()` calls
- Local state mutations

---

### Rule 3: Views Must Not Nest Other Views

Keep view hierarchy **flat**. A `_page` composes multiple `_view` widgets, but views cannot nest other views.

**❌ Wrong:**
```dart
class DashboardMainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeaderView(), // ❌ _view inside _view
        DashboardChartsView(), // ❌ Nested view
      ],
    );
  }
}
```

**✅ Correct:**
```dart
// In _page instead
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          DashboardHeaderView(), // ✅ _page composes _views
          DashboardChartsView(),
        ],
      ),
    );
  }
}
```

---

### Rule 4: Views Are Layout-Agnostic

Like components, views must not control their own size or positioning.

**Views MUST NOT use:**
- `MediaQuery.of(context).size` for sizing
- `LayoutBuilder` for responsive logic
- Hardcoded width/height
- Breakpoint utilities

**Exception:** Views can use simple layout widgets (`Column`, `Row`, `ListView`) to arrange components, but NOT for responsive logic.

---

### Rule 5: Proper Granularity

**Minimum granularity:** Header, List, Section level (not individual widgets)
**Maximum granularity:** Full-screen sections

**Test:** If it doesn't have independent state, it's probably a `_unit`, not a `_view`.

**✅ Good granularity:**
- `UserProfileHeaderView` - Listens to user state
- `OrdersListView` - Listens to orders state
- `StatisticsView` - Listens to analytics state

**❌ Too granular (should be `_unit`):**
```dart
class UserAvatarView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => CircleAvatar(
        backgroundImage: NetworkImage(state.avatarUrl),
      ), // ❌ Too small, should be UserAvatarUnit with state.avatarUrl passed in
    );
  }
}
```

---

## State Listening Patterns

### Pattern 1: Single State Listener

Most common pattern for focused views.

```dart
class UserProfileHeaderView extends StatelessWidget {
  const UserProfileHeaderView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.isLoading) {
          return CircularProgressIndicator();
        }
        
        return Column(
          children: [
            UserAvatarUnit(imageUrl: state.avatarUrl),
            UserNameUnit(name: state.name),
            UserEmailUnit(email: state.email),
          ],
        );
      },
    );
  }
}
```

---

### Pattern 2: Multiple States with Combined BLoC

When multiple states interact, use a **combined BLoC** instead of nested builders.

**✅ Correct - Combined state:**
```dart
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required UserRepository userRepo,
    required AnalyticsRepository analyticsRepo,
  }) {
    // Listen to multiple sources, emit combined state
  }
}

class DashboardView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardBloc, DashboardState>(
      builder: (context, state) {
        if (state.isPremium && state.hasAnalytics) {
          return PremiumDashboardContent();
        }
        return FreeDashboardContent();
      },
    );
  }
}
```

**❌ Wrong - Nested builders:**
```dart
class DashboardView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<AnalyticsBloc, AnalyticsState>( // ❌ Nested
          builder: (context, analyticsState) {
            // Complex nested conditionals
          },
        );
      },
    );
  }
}
```

---

### Pattern 3: Selector for Optimization

Use `BlocSelector` to rebuild only when specific state changes.

```dart
class UserNameView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocSelector<UserBloc, UserState, String>(
      selector: (state) => state.name,
      builder: (context, name) {
        return Text(name);
      },
    );
  }
}
```

---

## Component Composition

### Rule: Views Compose, Don't Define

Views **compose** components but don't define new visual styles.

**✅ Correct:**
```dart
class ProductsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final productVM = ProductViewModel.fromDomain(state.products[index]);
            return ProductCardUnit( // ✅ Composing pure component
              viewModel: productVM,
              actionSlot: AddToCartAction(productId: productVM.id),
            );
          },
        );
      },
    );
  }
}
```

**❌ Wrong:**
```dart
class ProductsListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final product = state.products[index];
            // ❌ Defining styles directly instead of using components
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(/* ... */),
              child: Column(/* ... */),
            );
          },
        );
      },
    );
  }
}
```

---

## View Validation Checklist

Before marking a view as complete, verify:

### ✅ State Projection Test

> **"Does this widget listen to state and project it to UI components?"**

If **NO**, it's not a view.

### ✅ Stateless Test

> **"Is this widget stateless? Does it avoid local state mutations?"**

If **NO**, it should be `_control` or refactored.

### ✅ Composition Test

> **"Does this view compose components rather than defining new styles?"**

If **NO**, extract components first.

### ✅ Granularity Test

> **"Does this view represent a logical section with independent state?"**

If **NO**, it's too granular (should be `_unit`).

### ✅ Layout Independence Test

> **"Does this view avoid MediaQuery, LayoutBuilder, and breakpoint logic?"**

If **NO**, extract layout logic to `_layout`.

### ✅ Nesting Test

> **"Does this view avoid nesting other `_view` widgets?"**

If **NO**, flatten the hierarchy.

---

## Quick Reference

### Separation of Concerns

| Concern | Who Decides |
|---------|-------------|
| State listening | **View** |
| State projection | **View** |
| Component composition | **View** |
| Loading/error/empty states | **View** |
| Width, Height, Max-width | **Layout** |
| Breakpoint logic | **Layout** |
| Responsive arrangement | **Layout** |
| Visual style, States | **Component** |
| User interactions | **Component** |

### View Authoring Checklist

- [ ] View listens to state (BlocBuilder/Consumer)
- [ ] View is stateless
- [ ] View projects state to components
- [ ] View does not nest other views
- [ ] View does not use MediaQuery for sizing
- [ ] View does not use LayoutBuilder
- [ ] View does not know about breakpoints
- [ ] View composes components, doesn't define styles
- [ ] View has proper granularity (section-level)
- [ ] View handles loading/error/empty states
- [ ] View converts domain entities to ViewModels
- [ ] View works with any layout container

---

**Remember**: Views = State Projection. They listen to state and compose components, but never define layout or styling.
