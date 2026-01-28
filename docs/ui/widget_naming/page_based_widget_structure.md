# Page-Based Widget Structure

This document outlines the structural patterns for organizing widgets within the application, following a **"Local First"** approach where widgets are kept as close as possible to where they are used.

---

## 1. Global Core Widgets (Atomic Design)

For widgets that are used across the entire application (not specific to a single feature), we use the **Atomic Design** system located in `lib/src/core/widgets`.

### The Folder Structure
```text
lib/src/core/widgets/
 ├── atoms/         <-- Basic building blocks (Buttons, Inputs, Texts)
 ├── molecules/     <-- Groups of atoms (Search Bars, User Class Cards)
 ├── organisms/     <-- Complex UI sections (Headers, Footers)
 ├── template/      <-- Page layouts without content
 └── pages/         <-- (Rarely used here, mostly for generic status pages)
```

**Rule:** If a widget is used in **2 or more features**, strictly move it here.

---

## 2. Page-Based Structure

The fundamental building block of our app is the **Page**. Each page folder should be a self-contained universe.

### The Folder Structure (Project View)

```text
lib/features/shop/presentation/
 │
 ├── shared_widgets/                     <-- FEATURE-LEVEL SHARED
 │    ├── shop_product_card.dart         <-- Promoted! Used by Search & Details
 │    └── shop_sale_badge.dart           <-- Promoted! Used by Card & Details
 │
 └── pages/
      ├── search/
      │    ├── search_page.dart
      │    └── widgets/                  <-- Local (Private)
      │         ├── search_input_bar.dart
      │         └── search_result_grid.dart (Imports ShopProductCard)
      │
      ├── product_details/
      │    ├── product_details_page.dart
      │    └── widgets/                  <-- Local (Private)
      │         ├── product_image_carousel.dart
      │         ├── product_info_card.dart (Imports ShopSaleBadge)
      │         └── similar_products_list.dart (Imports ShopProductCard)
      │
      └── profile/
           ├── profile_page.dart
           └── widgets/                  <-- Local (Private)
                └── profile_header_card.dart
```

### Deep Dive: Example Pages

Here is how the Widget Trees look for specific pages using this structure.

#### A. Search Page
*Context:* This page handles finding items. Even though `SearchInputBar` looks like a text field, we keep it here because it has specific logic (debounce, auto-focus) that other pages don't need.

**The Widget Tree (Runtime):**
```text
SearchPage (Scaffold)
 └── Column
     ├── SearchInputBar           <-- (1) The text field area
     ├── SearchFilterChips        <-- (2) Row: [Price] [Color] [Brand]
     └── Expanded
          └── Stack
               ├── SearchEmptyState     <-- (3) "No results found" image
               ├── ListView
               │    ├── SearchPromoBanner    <-- (4) "50% Off Nike"
               │    ├── SearchRecentHistory  <-- (5) "Last searched: Puma"
               │    └── SearchResultGrid     <-- (6) The actual products
```

#### B. Profile Page
*Context:* This page displays user settings. It has a completely different look from the rest of the app.

**The Widget Tree (Runtime):**
```text
ProfilePage (Scaffold)
 └── SingleChildScrollView
      └── Column
           ├── ProfileHeaderCard        <-- (1) User Photo & Name
           ├── ProfileWalletBadge       <-- (2) "Balance: $50.00"
           ├── ProfileOrderSummary      <-- (3) "Last order: Arriving Today"
           ├── Padding (Divider)
           ├── ProfileMenuOptions       <-- (4) "Account", "Privacy", "Help"
           ├── Row
           │    ├── Text("Dark Mode")
           │    └── ProfileDarkModeSwitch <-- (5) Toggle Switch
           └── ProfileLogoutButton      <-- (6) Red button at bottom
```

### Why this is better
1.  **No "God Classes":**
    *   Intern A works on `SearchInputBar`.
    *   Intern B works on `ProfileHeaderCard`.
    *   They never touch the same file. Merge conflicts are zero.
2.  **Context in Names:**
    *   If you see a file named `ProfileWalletBadge`, you know *exactly* what it does.
    *   If you named it just `WalletBadge`, you might be tempted to use it on the Checkout page, which breaks the "Local First" rule.
3.  **Specific Logic:**
    *   The `SearchInputBar` needs to trigger an API call when typing stops.
    *   The `ProfileDarkModeSwitch` needs to save a preference to local storage.
    *   By separating them, you don't have one complex widget trying to handle both API calls and Local Storage.

---

**See also:**
- [Section-Based Widget Structure](section_based_widget_structure.md) for complex pages.
- [Widget Naming System](widget_naming_system.md) for strict class naming rules.

