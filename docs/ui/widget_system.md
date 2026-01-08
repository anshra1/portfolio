## 0. Purpose

This document is the **single source of truth** for the Presentation Layer.

- It binds **Humans and AI agents** equally.
- Any deviation is a **violation**, not a preference.
- If two rules conflict, the **stricter rule wins**.

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

---

### 1.2 The Middleman Rule (Composition)

- **No Blind Passthroughs.**
- If a widget accepts a parameter *only to forward it* to a child, that parameter is **forbidden**.

### Required Pattern: Slots

- Accept **pre‑built Widgets**, not configuration.
- Pass the *cake*, not the *ingredients*.

**Forbidden:**

```dart
MyCard({String title, VoidCallback onTap})

```

**Required:**

```dart
MyCard({required Widget actionSlot})

```

---

## 2. Classification Logic (Order of Operations)

Apply these rules **top‑down**. First match wins.

1. **Usage:** Exists exactly once → **Static Widget**
2. **Usage:** Reused + display‑only → **Reusable Widget**
3. **Behavior:** Reacts to Logic State (show/hide/build) → **State‑Driven Widget**
4. **Behavior:** Owns a UI Controller → **Controller Adapter**
5. **Interaction:** User can interact → **User Action Widget**

> Escape Hatch: If a widget fits two categories, split it into two widgets.
> 

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

## 4. Widget Categories

### 4.1 Static Widgets — `_visual`

**Definition:** Display‑only widgets used **exactly once**.

- No state
- No callbacks
- No logic

**Examples:**

- `login_header_visual.dart`
- `app_logo_visual.dart`

---

### 4.2 Reusable Widgets — `_unit`

**Definition:** Dumb building blocks used multiple times.

**Constraints:**

- Stateless only
- Primitives / ViewModels only
- Must use **Slots** for variability

**Examples:**

- `login_info_tile_unit.dart`
- `profile_stat_row_unit.dart`

> kit_ widgets are implicitly primitive and may omit _unit.
> 

---

### 4.3 State‑Driven Widgets — `_view`

**Definition:** Project Logic Layer state into **UI structure**.

**Responsibilities:**

- Conditional rendering
- Lists (`ListView.builder`)
- State listeners (`BlocBuilder`, `Consumer`, etc.)

**Constraints:**

- No local mutation
- No controllers

**Examples:**

- `login_form_view.dart`
- `orders_list_view.dart`

---

## 5. User Action Widgets (Intent Owners)

> Any widget the user can interact with owns intent.
> 

### 5.1 Local Control — `_control`

**Purpose:** Ephemeral, UI‑only state.

- Toggles
- Tabs
- Expand / Collapse

**Rules:**

- No Logic Layer access
- Disposable state only

**Examples:**

- `theme_switch_control.dart`

---

### 5.2 Logic Trigger — `_action`

**Purpose:** Emit intent to the Logic Layer.

**Core Rule:**

- Dispatch intent only
- Execute **zero** logic

**Sub‑types:**

- Flow‑only (navigation)
- Data‑affecting (submit, retry, delete)

**Examples:**

- `login_submit_action.dart`
- `app_logout_action.dart`

---

### 5.3 Controller Adapter (Quarantine) — `_input`

**Definition:** Bridge dirty UI controllers with clean Logic.

**Owns:**

- `TextEditingController`
- `ScrollController`
- Media / Animation controllers

**Rules:**

- Controllers never escape this widget
- Sync Controller → Intent
- Sync State → Controller
- **Only place StatefulWidget is allowed in Actions**

**Examples:**

- `email_input.dart`
- `search_input.dart`

---

## 6. Page Widget — `_page`

**Definition:** Top‑level composition root.

**Responsibilities:**

- Dependency Injection
- Initial intents
- Layout composition

**Constraints:**

- No business rules
- No data access

**Example:**

- `login_page.dart`

---

## 7. Folder Structure (Canonical)

```
lib/
├── core/shared_widgets/
│   ├── static/
│   ├── views/
│   └── actions/
│
├── features/auth/presentation/
│   ├── pages/
│   └── widgets/
│       ├── static/
│       ├── views/
│       └── actions/
│
└── (External Package)/lib/src/widgets/

```

---

## 8. Explicitly Forbidden

1. Logic inside `_visual` or `_unit`
2. Passing Domain Entities into widgets
3. Blind prop‑drilling without Slots
4. Controllers leaving `_input` widgets
5. StatefulWidgets outside `_control` and `_input`

---

## 9. One‑Line Mental Model

- `_visual` → looks pretty
- `_unit` → dumb lego
- `_view` → listens to state
- `_control` → toggles pixels
- `_action` → fires intent
- `_input` → manages controllers
- `_page` → glues everything

---

**This document is final.**