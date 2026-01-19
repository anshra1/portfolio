## 0. Purpose

This document is the **single source of truth** for the Presentation Layer.

- It binds **Humans and AI agents** equally.
- Any deviation is a **violation**, not a preference.
- If two rules conflict, the **stricter rule wins**.

---

## 0.1 UI Rules Integration

This widget naming system works in conjunction with the UI architectural rules. Each widget category must follow specific rule documents:

### Widget Categories → UI Rules Mapping

| Widget Category | UI Rule Document | What It Must Follow |
|----------------|------------------|---------------------|
| `_visual`, `_unit`, `_action`, `_control`, `_input` | [Component Rules](ui_rules/component.md) | Size-agnostic, container-neutral, no breakpoint logic |
| `_view` | [View Rules](ui_rules/view.md) | State projection, compose components, stateless |
| `_layout` | [Layout Rules](ui_rules/layout.md) | Control space/structure, know breakpoints, arrange components |
| `_page` | [Page Rules](ui_rules/page.md) | Compose sections, own routing, delegate to layouts |

### Quick Reference

**Pure components** (`_visual`, `_unit`, `_action`, `_control`, `_input`, `_section`) must:
- ✅ Be size-agnostic (no width/height)
- ✅ Work in any container (ListView, GridView, Row, Column)
- ✅ Not know about breakpoints
- ✅ Not use MediaQuery for breakpoint logic (proportional sizing OK)
- ✅ Degrade gracefully
- ✅ Not listen to state

> **Note on `_visual`:** Can use `context` to access Flutter-provided values (Theme, MediaQuery, Localizations) but cannot accept user-provided constructor parameters.

**`_view` widgets** must:
- ✅ Listen to state (BlocBuilder, Consumer)
- ✅ Project state to components
- ✅ Be stateless (no local state)
- ✅ Compose pure components
- ✅ Can nest other `_view` widgets (they are independent data connectors)
- ✅ Not control layout/breakpoints

> **Note on `_view`:** This is an optional **data connector layer**, not a UI building block. Build your UI with components first, then wrap with `_view` when external state is needed. Only widgets that fetch external data need the `_view` suffix.

**`_layout` widgets** must:
- ✅ Know about breakpoints
- ✅ Control component sizing and spacing
- ✅ Arrange `_view` widgets and components

**`_page` widgets** must:
- ✅ Compose sections
- ✅ Delegate to `_layout` for responsive behavior
- ✅ Not style components
- ✅ Not contain responsive logic directly

**See also:** [Responsive Rules](ui_rules/responsive.md) for breakpoint patterns and responsive design principles.

---

## Architectural Overview

### Four-Layer Architecture

```
┌─────────────────────────────────────────────────────────┐
│  Layer 1: _page (Screen Entry Point)                   │
│  - Routing & DI setup                                   │
│  - Composes layouts                                     │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│  Layer 2: _layout (Responsive Structure)                │
│  - Breakpoint logic                                     │
│  - Component sizing & spacing                           │
│  - Arranges components                                  │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│  Layer 3: Components (Pure Building Blocks)             │
│  - _visual, _unit (Display)                             │
│  - _action (Intent triggers)                            │
│  - _control (Local state)                               │
│  - _input (Controller quarantine)                       │
└─────────────────────────────────────────────────────────┘
                        ↓
┌─────────────────────────────────────────────────────────┐
│  Optional: _view (Data Connector)                       │
│  - Wraps components when external state is needed       │
│  - Listens to state (BlocBuilder, Consumer)             │
│  - Added LAST after UI is designed with components      │
└─────────────────────────────────────────────────────────┘
```

### Key Separation Principles

| Concern | Layer Responsible |
|---------|------------------|
| **State Listening** | `_view` only |
| **Breakpoint Logic** | `_layout` only |
| **Routing** | `_page` only |
| **Visual Styling** | Components only |
| **User Interaction** | Components only |

**Critical Rule:** Components never listen to state. Views never control layout. Layouts never listen to state. Pages never define styles.

---

## 1. Core Philosophy (Non‑Negotiable)

1. **Rendering and Intent are separate concerns.**
2. **Widgets that only show data are never actions.**
3. **Widgets that accept user interaction always represent intent.**
4. **No widget executes business rules or I/O.**

### 1.1 The Data Hygiene Rule (Global)

- **Primitives or ViewModels only.**
- Widgets must **never** accept raw Domain Entities (`User`, `Order`, `Product`).
- Accept only:
    - UI‑Primitives (`String`, `int`, `bool`, `Color`, etc.)
    - Explicit UI ViewModels built for rendering

**Why:** UI must survive Domain / Database refactors without change.

#### ViewModel Guidelines

- **Location:** `feature/presentation/models/` or `core/presentation/models/`
- **Naming:** `[Entity]ViewModel` (e.g., `OrderViewModel`, `UserProfileViewModel`)
- **Immutability:** Must be immutable (use `@immutable` or `freezed`)
- **Purpose:** Transform domain entities into UI‑ready data structures
- **Factory pattern:** Use `ViewModel.fromDomain(entity)` for conversion

**Example:**
```dart
@immutable
class OrderViewModel {
  final String orderId;
  final String displayDate;
  final String formattedTotal;
  final Color statusColor;
  
  const OrderViewModel({
    required this.orderId,
    required this.displayDate,
    required this.formattedTotal,
    required this.statusColor,
  });
  
  factory OrderViewModel.fromDomain(Order order) {
    return OrderViewModel(
      orderId: order.id,
      displayDate: DateFormat.yMMMd().format(order.createdAt),
      formattedTotal: '\$${order.total.toStringAsFixed(2)}',
      statusColor: _getStatusColor(order.status),
    );
  }
}
```

---

### 1.2 The Middleman Rule (Composition)

- **No Blind Passthroughs.**
- If a widget accepts a parameter *only to forward it* to a child, that parameter is **forbidden**.

### Required Pattern: Slots

- Accept **pre‑built Widgets**, not configuration.
- Pass the *cake*, not the *ingredients*.

**Forbidden:**

```dart
MyCard({String title, VoidCallback onTap}) // ❌ Blind passthrough
```

**Required:**

```dart
MyCard({required Widget actionSlot}) // ✅ Pre-built widget
```

**Why Slots Are Superior:**

| Aspect | Callback Pattern | Slot Pattern |
|--------|------------------|--------------|
| **Semantic clarity** | ❌ Generic, unclear | ✅ Specific, named |
| **Testability** | ❌ Test callback logic | ✅ Test widget composition |
| **Reusability** | ⚠️ Illusory | ✅ True composition |
| **Responsibility** | ❌ Middleman | ✅ Layout owner |
| **Intent visibility** | ❌ Hidden in callback | ✅ Explicit in widget type |

**Example:**

```dart
// ❌ FORBIDDEN: Callback pattern
class ProfileCard extends StatelessWidget {
  final String name;
  final VoidCallback onEdit; // ❌ Middleman
  
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(name),
          ElevatedButton(onPressed: onEdit, child: Text('Edit')),
        ],
      ),
    );
  }
}

// ✅ REQUIRED: Slot pattern
class ProfileCardUnit extends StatelessWidget {
  final String name;
  final Widget actionSlot; // ✅ Pre-built widget
  
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(name),
          actionSlot, // Parent decides what
        ],
      ),
    );
  }
}

// Usage
ProfileCardUnit(
  name: 'John',
  actionSlot: ProfileEditAction(), // Clear intent
)
```

> **Exception for `kit_` Primitives:** Design system widgets (`kit_*`) like `KitButton`, `KitCard`, etc. are exempt from this rule. They are infrastructure primitives and require callbacks to function. This rule applies to feature widgets (`login_*`, `app_*`) only.

---

## 2. Classification Logic (Order of Operations)

Apply these rules **top‑down**. First match wins.

### Layer Classification (Check First)

1. **Scope:** Screen entry point → **Page (`_page`)**
2. **Scope:** Responsive/breakpoint arrangement → **Layout (`_layout`)**
3. **Behavior:** Listens to Logic State → **State Projection (`_view`)**

### Component Classification (Then Check)

4. **Parameters:** No instance fields → **Static Widget (`_visual`)**
5. **Parameters:** Accepts values only (one‑way) → **Reusable Widget (`_unit`)**
6. **Behavior:** Owns a UI Controller → **Controller Adapter (`_input`)**
7. **Interaction:** Local UI state only → **Local Control (`_control`)**
8. **Interaction:** Triggers Logic Layer → **User Action Widget (`_action`)**

> **Rationale:** Layers (_page, _layout, _view) are evaluated first because they have broader scope and responsibilities. Components are pure building blocks evaluated last.

> **Escape Hatch:** If a widget fits two categories, split it into two widgets.

---

## 3. Naming Convention (Mandatory)

Every widget **class and file** MUST follow:

```
[prefix]_[name]_[suffix].dart
```

### 3.1 Prefix Rules (Scope)

| Scope | Prefix | Meaning |
| --- | --- | --- |
| Feature‑local | `login_` | Exists only inside one feature |
| App‑wide internal | `app_` | Shared across features |
| External design system | `kit_` | Imported package primitives |

---

### 3.2 Suffix Rules (Category)

#### Layers

| Suffix | Category | Purpose |
| --- | --- | --- |
| `_page` | Page | Screen entry point |
| `_layout` | Responsive Layout | Breakpoint‑specific arrangement |
| `_view` | State Projection | Listens to state, projects to components |

#### Components

| Suffix | Category | Purpose |
| --- | --- | --- |
| `_visual` | Static Widget | Pure static rendering, no parameters |
| `_unit` | Reusable Widget | Display‑only, accepts values |
| `_action` | User Action | Triggers logic layer intent |
| `_control` | Local Control | Ephemeral UI state only |
| `_input` | Controller Adapter | Owns UI controllers |
| `_section` | Section Container | Top-level section composing other widgets |

---

## 4. Widget Categories (Detailed)

### 4.1 Static Widgets — `_visual`

**Definition:** Pure static rendering with **zero instance fields**.

**Rules:**

✅ **Allowed:**
- Use `context` (Theme, MediaQuery, etc.)
- Hardcoded literals
- Only `super.key` in constructor

❌ **Forbidden:**
- Any instance fields
- Constructor parameters (except `Key`)
- Callbacks
- State

**Examples:**

```dart
// ✅ VALID
class LoginHeaderVisual extends StatelessWidget {
  const LoginHeaderVisual({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Welcome Back',
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Icon(Icons.login, size: 48),
      ],
    );
  }
}

// ❌ INVALID - has instance field
class LoginHeaderVisual extends StatelessWidget {
  final String title; // ❌ FORBIDDEN
  const LoginHeaderVisual({super.key, required this.title});
  ...
}
```

**File Examples:**
- `login_header_visual.dart`
- `app_logo_visual.dart`
- `empty_state_visual.dart`

---

### 4.2 getting data from from parent Widgets — `_unit`

**Definition:** Dumb building blocks that **receive data from parent** via constructor parameters. One‑way data flow only (parent → child).

**Core Concept:** A `_unit` widget is **given** data, it doesn't fetch or manage it. The parent decides what data to pass down.

**Constraints:**

- Stateless only

**Rules:**

✅ **Allowed:**
- Accept primitives, ViewModels, widget slots
- Use `context`
- Display received data

❌ **Forbidden:**
- Callbacks (use slot pattern instead)
- State management
- Logic execution
- Blind passthroughs

**Examples:**

```dart
// ✅ VALID - One-way data only
class ProfileStatRowUnit extends StatelessWidget {
  final String label;
  final int value;
  
  const ProfileStatRowUnit({
    super.key,
    required this.label,
    required this.value,
  });
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(width: 8),
        Text('$value', style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}

// ✅ VALID - Using slot pattern
class OrderCardUnit extends StatelessWidget {
  final OrderViewModel viewModel;
  final Widget actionSlot;
  
  const OrderCardUnit({
    super.key,
    required this.viewModel,
    required this.actionSlot,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(viewModel.orderId),
          Text(viewModel.displayDate),
          Text(viewModel.formattedTotal),
          actionSlot, // Pre-built action
        ],
      ),
    );
  }
}

// ❌ INVALID - has callback
class ProfileStatRowUnit extends StatelessWidget {
  final String label;
  final VoidCallback onTap; // ❌ FORBIDDEN - Use slot pattern
  ...
}
```

**File Examples:**
- `login_info_tile_unit.dart`
- `order_card_unit.dart`
- `stat_display_unit.dart`

> **Note:** `kit_` widgets are implicitly primitive and may omit `_unit` suffix.

---

### 4.2b Section Container — `_section`

**Definition:** A high-level composite widget that defines a major area of the page (e.g. Hero, Footer).

**Purpose:** Groups multiple smaller components (`_visual`, `_action`, `_unit`) into a coherent block.

**Rules:**
✅ **Allowed:**
- Compose multiple widgets
- Use `context` (Theme, Breakpoints via Layouts)

❌ **Forbidden:**
- Business Logic (use `_view` if it needs to listen to BLoC)
- Complex Layout Logic (delegate to `_layout` if complex)

**Examples:**
```dart
// ✅ VALID
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeroTitleVisual(),
        HeroActionsLayout(),
      ],
    );
  }
}
```

---

### 4.3 State‑Driven Widgets — `_view`

**Definition:** Logical sections of a page that **listen to state** and project it into UI structure.

**Key Concept:** A `_page` composes **multiple `_view` widgets**, where each `_view` represents a distinct logical area.

**Rules:**

✅ **Allowed:**
- Listen to state (BlocBuilder, Consumer, Selector, etc.)
- Conditional rendering based on state
- List building (ListView.builder)
- Compose `_unit`, `_visual`, `_action`, `_control`
- Use `context`
- Minimal route/ID parameters

❌ **Forbidden:**
- Callbacks as parameters (use slot pattern or compose `_action` directly)
- Local mutation (no `setState`)
- Controllers (that's `_input`)
- Nested `_view` widgets (keep hierarchy flat)

**Granularity Rule:**

- **Minimum:** Header, List, Section level (not individual widgets)
- **Maximum:** Full‑screen sections
- **Test:** If it doesn't have independent state, it's probably a `_unit`

**Examples:**

```dart
// ✅ VALID - Focused section
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

// ✅ VALID - List section
class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersBloc, OrdersState>(
      builder: (context, state) {
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

// ❌ INVALID - Too granular (should be _unit)
class UserAvatarView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) => CircleAvatar(backgroundImage: NetworkImage(state.avatarUrl)),
    );
  }
}

// ✅ VALID - Nested _view widgets are allowed
// Each _view is an independent data connector
class DashboardMainView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeaderView(), // ✅ Independent data connector for UserBloc
        DashboardChartsView(), // ✅ Independent data connector for AnalyticsBloc
      ],
    );
  }
}
```

**Multi‑State Pattern:**

When multiple states interact, use a **combined BLoC** instead of nested builders:

```dart
// ✅ GOOD - Combined state
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
        // Single state, clean conditionals
        if (state.isPremium && state.hasAnalytics) {
          return PremiumDashboardLayout();
        }
        return FreeDashboardLayout();
      },
    );
  }
}

// ❌ BAD - Nested builders
class DashboardView extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        return BlocBuilder<AnalyticsBloc, AnalyticsState>( // ❌ Nested builders
          builder: (context, analyticsState) {
            // Complex nested conditionals
          },
        );
      },
    );
  }
}
```

**File Examples:**
- `login_form_view.dart`
- `orders_list_view.dart`
- `user_profile_header_view.dart`
- `statistics_dashboard_view.dart`

---

### 4.4 Local Control — `_control`

**Purpose:** Ephemeral, UI‑only state.

**Rules:**

✅ **Allowed:**
- Local state (toggles, tabs, expand/collapse)
- StatefulWidget
- Dispose state on unmount

❌ **Forbidden:**
- Logic Layer access
- Persistent state
- Data that survives widget disposal

**Examples:**

```dart
// ✅ VALID
class ThemeSwitchControl extends StatefulWidget {
  const ThemeSwitchControl({super.key});
  
  @override
  State<ThemeSwitchControl> createState() => _ThemeSwitchControlState();
}

class _ThemeSwitchControlState extends State<ThemeSwitchControl> {
  bool _isDark = false;
  
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDark,
      onChanged: (value) => setState(() => _isDark = value),
    );
  }
}

// ❌ INVALID - Persists to logic layer
class ThemeSwitchControl extends StatefulWidget {
  @override
  State<ThemeSwitchControl> createState() => _ThemeSwitchControlState();
}

class _ThemeSwitchControlState extends State<ThemeSwitchControl> {
  bool _isDark = false;
  
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: _isDark,
      onChanged: (value) {
        setState(() => _isDark = value);
        context.read<SettingsBloc>().add(ThemeChanged(value)); // ❌ Logic layer access
      },
    );
  }
}
```

**File Examples:**
- `theme_switch_control.dart`
- `accordion_control.dart`
- `tab_selector_control.dart`

---

### 4.5 Logic Trigger — `_action`

**Purpose:** Emit intent to the Logic Layer.

**Core Rule:**
- Dispatch intent only
- Execute **zero** logic

**Sub‑types:**
- Flow‑only (navigation)
- Data‑affecting (submit, retry, delete)

**Examples:**

```dart
// ✅ VALID - Triggers logic layer
class LoginSubmitAction extends StatelessWidget {
  const LoginSubmitAction({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<AuthBloc>().add(LoginSubmitted());
      },
      child: Text('Login'),
    );
  }
}

// ✅ VALID - With parameter
class OrderDetailsAction extends StatelessWidget {
  final String orderId;
  
  const OrderDetailsAction({
    super.key,
    required this.orderId,
  });
  
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<OrdersBloc>().add(OrderDetailsRequested(orderId));
      },
      child: Text('View Details'),
    );
  }
}

// ❌ INVALID - Contains logic
class LoginSubmitAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final email = emailController.text; // ❌ Logic
        if (email.isEmpty) return; // ❌ Validation
        context.read<AuthBloc>().add(LoginSubmitted(email));
      },
      child: Text('Login'),
    );
  }
}
```

**File Examples:**
- `login_submit_action.dart`
- `app_logout_action.dart`
- `order_delete_action.dart`

---

### 4.6 Controller Adapter (Quarantine) — `_input`

**Definition:** Bridge dirty UI controllers with clean Logic.

**Owns:**
- `TextEditingController`
- `ScrollController`
- `FocusNode`
- Media / Animation controllers

**Rules:**

✅ **Allowed:**
- StatefulWidget (required)
- Controller lifecycle management
- Sync Controller → Intent
- Sync State → Controller

❌ **Forbidden:**
- Controllers escaping this widget
- Business logic
- Validation logic (dispatch to BLoC instead)

**Examples:**

```dart
// ✅ VALID
class EmailInput extends StatefulWidget {
  const EmailInput({super.key});
  
  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late final TextEditingController _controller;
  
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }
  
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        // Sync state → controller
        if (state.emailResetRequested) {
          _controller.clear();
        }
      },
      child: TextField(
        controller: _controller,
        onChanged: (value) {
          // Sync controller → intent
          context.read<AuthBloc>().add(EmailChanged(value));
        },
        decoration: InputDecoration(
          labelText: 'Email',
        ),
      ),
    );
  }
}

// ❌ INVALID - Controller exposed
class EmailInput extends StatefulWidget {
  final TextEditingController controller; // ❌ FORBIDDEN - Controller escapes
  const EmailInput({super.key, required this.controller});
  ...
}

// ❌ INVALID - Contains validation
class EmailInput extends StatefulWidget {
  ...
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      onChanged: (value) {
        if (!value.contains('@')) { // ❌ Validation logic
          // show error
        }
        context.read<AuthBloc>().add(EmailChanged(value));
      },
    );
  }
}
```

**File Examples:**
- `email_input.dart`
- `search_input.dart`
- `password_input.dart`

---

### 4.7 Responsive Layout — `_layout`

**Definition:** Breakpoint‑specific arrangement of widgets.

**Purpose:** Handle responsive/adaptive UI without polluting `_page` or `_view`.

**Layout Scope:**

`_layout` widgets can exist at two levels:

| Scope | Location | Purpose | Example |
|-------|----------|---------|--------|
| **Page-level** | `page_layout/` | How the entire page arranges | `home_page_web_layout.dart` |
| **Component-level** | `widgets/widget_layout/` | How a component arranges internally | `order_card_expanded_layout.dart` |

> **Key Principle:** Components remain size-agnostic. The **parent layout** decides which component layout variant to use.

**Rules:**

✅ **Allowed:**
- Arrange components and `_view` widgets
- Breakpoint‑specific composition
- Responsive sizing/positioning

❌ **Forbidden:**
- State listening (use `_view` wrapper instead)
- Business logic
- Heavy rendering (delegate to `_view`)

**Examples:**

```dart
// ✅ VALID - Responsive layout
class HomeLayoutWeb extends StatelessWidget {
  const HomeLayoutWeb({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: HomeHeroView(),
        ),
        Expanded(
          flex: 3,
          child: HomeProjectsView(),
        ),
        Expanded(
          flex: 1,
          child: HomeSidebarView(),
        ),
      ],
    );
  }
}

class HomeLayoutMobile extends StatelessWidget {
  const HomeLayoutMobile({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HomeHeroView(),
        HomeProjectsView(),
        // Sidebar omitted on mobile
      ],
    );
  }
}

// ❌ INVALID - State listening (should be _view)
class HomeLayoutWeb extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>( // ❌ Should be in _view
      builder: (context, state) { ... },
    );
  }
}
```

**File Examples:**
- `home_layout_web.dart`
- `home_layout_tablet.dart`
- `home_layout_mobile.dart`
- `dashboard_layout_desktop.dart`

---

### 4.8 Page Widget — `_page`

**Definition:** Top‑level composition root and screen entry point.

**Responsibilities:**
- Dependency Injection (BlocProvider, etc.)
- Initial intents/events
- Scaffold/AppBar setup
- Compose multiple `_view` widgets
- Route parameter handling
- Responsive layout switching

**Constraints:**
- No business rules
- No data access
- No state listening (delegate to `_view`)
- Should be thin

**Architecture:**
```
_page (entry)
  ↓
  • DI setup
  • Initial events
  • Scaffold
  ↓
Multiple _view widgets (sections)
  ↓
_unit + _visual + _action + _control
```

**Examples:**

```dart
// ✅ VALID - Thin page
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()
        ..add(LoginPageOpened()),
      child: Scaffold(
        appBar: AppBar(title: Text('Login')),
        body: LoginFormView(), // Delegates to _view
      ),
    );
  }
}

// ✅ VALID - Multiple views
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => UserBloc()..add(UserLoaded())),
        BlocProvider(create: (_) => AnalyticsBloc()..add(AnalyticsLoaded())),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text('Dashboard')),
        body: Column(
          children: [
            UserProfileHeaderView(),  // _view #1
            StatisticsView(),          // _view #2
            RecentActivityView(),      // _view #3
          ],
        ),
      ),
    );
  }
}

// ✅ VALID - Responsive switching
class HomePage extends StatelessWidget {
  const HomePage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return HomeLayoutWeb();
          } else if (constraints.maxWidth > 600) {
            return HomeLayoutTablet();
          } else {
            return HomeLayoutMobile();
          }
        },
      ),
    );
  }
}

// ❌ INVALID - Fat page with rendering logic
class DashboardPage extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: Scaffold(
        body: BlocBuilder<DashboardBloc, DashboardState>( // ❌ Should be in _view
          builder: (context, state) {
            if (state.isLoading) return CircularProgressIndicator();
            return Column(children: [...]);
          },
        ),
      ),
    );
  }
}
```

**File Examples:**
- `login_page.dart`
- `home_page.dart`
- `dashboard_page.dart`

---

## 5. Folder Structure

For detailed folder organization, see: **[Widget Folder Structure](widget_folder_structure.md)**

**Quick Summary:**

| Widget Type | Folder |
|-------------|--------|
| `_page` | `pages/` |
| `_layout` (page-level) | `page_layout/` |
| `_layout` (component-level) | `widgets/widget_layout/` |
| `_view` | `widgets/views/` |
| `_visual` | `widgets/visuals/` |
| `_unit` | `widgets/units/` |
| `_action` | `widgets/actions/` |
| `_control` | `widgets/controls/` |
| `_input` | `widgets/inputs/` |

---

## 6. Explicitly Forbidden (With Examples)

### ❌ 1. Logic inside `_visual` or `_unit`

```dart
// ❌ FORBIDDEN
class PriceDisplayUnit extends StatelessWidget {
  final double price;
  
  Widget build(BuildContext context) {
    final discounted = price * 0.9; // ❌ Business logic
    return Text('\$$discounted');
  }
}

// ✅ CORRECT - Logic in BLoC, ViewModel has final value
class PriceDisplayUnit extends StatelessWidget {
  final String formattedPrice; // Already calculated
  
  Widget build(BuildContext context) {
    return Text(formattedPrice);
  }
}
```

### ❌ 2. Passing Domain Entities into widgets

```dart
// ❌ FORBIDDEN
class OrderCard extends StatelessWidget {
  final Order order; // ❌ Domain entity
  
  Widget build(BuildContext context) {
    return Text(order.id);
  }
}

// ✅ CORRECT
class OrderCardUnit extends StatelessWidget {
  final OrderViewModel viewModel; // ✅ ViewModel
  
  Widget build(BuildContext context) {
    return Text(viewModel.orderId);
  }
}
```

### ❌ 3. Blind prop‑drilling without Slots

```dart
// ❌ FORBIDDEN
class ProfileCard extends StatelessWidget {
  final VoidCallback onEdit; // ❌ Middleman
  
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onEdit, // Just forwarding
      child: Text('Edit'),
    );
  }
}

// ✅ CORRECT
class ProfileCardUnit extends StatelessWidget {
  final Widget actionSlot; // ✅ Pre-built widget
  
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text('Profile'),
          actionSlot,
        ],
      ),
    );
  }
}
```

### ❌ 4. Controllers leaving `_input` widgets

```dart
// ❌ FORBIDDEN
class EmailInput extends StatefulWidget {
  final TextEditingController controller; // ❌ Exposed controller
  const EmailInput({required this.controller});
  ...
}

// ✅ CORRECT
class EmailInput extends StatefulWidget {
  const EmailInput({super.key}); // ✅ Controller internal
  
  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  late final TextEditingController _controller; // ✅ Private
  ...
}
```

### ❌ 5. StatefulWidgets outside `_control` and `_input`

```dart
// ❌ FORBIDDEN
class OrderCardUnit extends StatefulWidget { // ❌ _unit should be Stateless
  ...
}

// ✅ CORRECT
class OrderCardUnit extends StatelessWidget { // ✅ Stateless
  ...
}
```

### ✅ 6. Nested `_view` widgets (Now Allowed)

`_view` widgets can contain other `_view` widgets since they are **independent data connectors**, not UI building blocks.

```dart
// ✅ ALLOWED - Each _view connects to its own data source
class DashboardMainView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        DashboardHeaderView(), // ✅ Connects to UserBloc
        DashboardChartsView(), // ✅ Connects to AnalyticsBloc
      ],
    );
  }
}
```

---

## 7. Decision Tree

**Use this flowchart to determine widget category:**

```
START: I need to create a widget
  ↓
Is it a screen entry point?
  YES → _page
  NO ↓
  
Is it a responsive/breakpoint variant?
  YES → _layout
  NO ↓

Does it accept ANY parameters?
  NO → _visual
  YES ↓
  
Does it have user interaction?
  NO → _unit
  YES ↓
  
Does it own a Controller?
  YES → _input
  NO ↓
  
Does interaction affect logic layer?
  NO → _control
  YES → _action

─────────────────────────────────────
AFTER UI IS BUILT:
─────────────────────────────────────
Does this component need external state?
  YES → Wrap with _view (data connector)
  NO → Keep as pure component
```

---

## 8. One‑Line Mental Model

### Layers (Broad Scope)

- `_page` → Screen entry point, routing, DI setup, composes sections
- `_layout` → Breakpoint-aware, arranges views/components responsively
- `_view` → State listener, projects logic state to UI components

### Components (Pure Building Blocks)

- `_visual` → Pure static, hardcoded content (no parameters)
- `_unit` → Receives values, displays them (one-way data)
- `_action` → Fires intent to logic layer (user interactions)
- `_control` → Ephemeral UI state only (toggles, tabs)
- `_input` → Manages controllers in quarantine (TextField, etc.)


---

## 9. Hierarchy & Composition Rules

**Allowed Composition Paths:**

```
_page
  ↓
  └─ _layout (responsive)
       ↓
       └─ Components
            ├─ _visual
            ├─ _unit
            ├─ _control
            ├─ _action
            └─ _input

Components can be wrapped with _view when external state is needed.
_view widgets can contain other _view widgets (independent data connectors).

_unit
  ↓
  ├─ _visual
  ├─ _unit (nested units OK)
  └─ widget slots (any type)
```

**Forbidden Compositions:**

- ❌ `_visual` → anything (must be self-contained)
- ❌ `_action` → `_action` (no nested actions)
- ❌ `_unit` → `_view` (units can't listen to state directly — use slots)
- ❌ `_layout` → state listening (use `_view` wrapper if layout decision needs state)

---

**This document is final.**