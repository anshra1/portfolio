# Homepage Implementation Plan

## Phase 1: Core Content Sections (Projects & Learnings)
**Goal:** Implement the data-heavy display sections using strict "Unit" and "Visual" patterns, creating the foundation for the homepage content.

### 1. ViewModels (Presentation Layer Data)
We must define strict ViewModels to adhere to the "Data Hygiene Rule". These will be simple Dart classes.

*   **File:** `lib/features/homepage/presentation/view_models/project_vm.dart`
    *   **Fields:** `String title`, `String description`, `String imageUrl`, `List<String> tags`.
*   **File:** `lib/features/homepage/presentation/view_models/article_vm.dart`
    *   **Fields:** `String title`, `String date`, `String readTime`, `String imageUrl`, `List<String> hashtags`.

### 2. Unit Widgets (Reusable Building Blocks)
These are dumb, stateless widgets that accept ViewModels and Slots.

*   **File:** `lib/features/homepage/presentation/widgets/units/home_project_card_unit.dart`
    *   **Purpose:** Displays a single project card.
    *   **Input:** `ProjectVM` (data).
    *   **Slots:**
        *   `Widget primaryActionSlot` (e.g., Download Button)
        *   `Widget secondaryActionSlot` (e.g., GitHub Button)
    *   **Composition:** Uses `KitCard` (if available) or styled `Container` with `core_ui_kit` tokens.
*   **File:** `lib/features/homepage/presentation/widgets/units/home_learning_card_unit.dart`
    *   **Purpose:** Displays a single article/learning card.
    *   **Input:** `ArticleVM` (data).
    *   **Slots:**
        *   `Widget readActionSlot` (e.g., Read Button)
    *   **Composition:** Vertical layout with image, text, and action slot.

### 3. Visual Widgets (Section Layouts)
Display-only widgets used exactly once to structure the sections.

*   **File:** `lib/features/homepage/presentation/widgets/static/home_projects_layout_visual.dart`
    *   **Purpose:** Lays out the Projects section (Grid/Wrap).
    *   **Slots:**
        *   `List<Widget> projectCardsSlot`
        *   `Widget showMoreActionSlot`
*   **File:** `lib/features/homepage/presentation/widgets/static/home_learnings_layout_visual.dart`
    *   **Purpose:** Lays out the Learnings section.
    *   **Slots:**
        *   `List<Widget> learningCardsSlot`
        *   `Widget viewAllActionSlot`

### 4. Layout Integration (Mock Data)
Update the existing platform-specific files to render these new components using mock data.

*   **Files:** `home_page_mobile.dart`, `home_page_tablet.dart`, `home_page_web.dart`
*   **Action:**
    *   Create mock `ProjectVM` and `ArticleVM` lists.
    *   Instantiate `HomeProjectCardUnit` and `HomeLearningCardUnit` with mock data and `KitPrimaryButton`/`KitOutlineButton` in slots.
    *   Pass these lists to `HomeProjectsLayoutVisual` and `HomeLearningsLayoutVisual`.
    *   Place them in a `SingleChildScrollView` (or CustomScrollView) in the `body`.

---

## Phase 2: Structural & Static Content (Rest of App)
**Goal:** Implement the remaining static sections (Header, Hero, About, Expertise, Footer) to complete the visual structure.

### 1. Static/Visual Widgets
*   **`home_header_visual.dart`:**
    *   Sticky header structure.
    *   Slots: `logoSlot`, `desktopNavSlot`, `mobileMenuSlot`.
*   **`home_hero_visual.dart`:**
    *   Main introductory section.
    *   Slots: `primaryCtaSlot`, `secondaryCtaSlot`, `socialsSlot`.
*   **`home_about_section_visual.dart`:**
    *   "About Me" text and avatar layout.
*   **`home_expertise_layout_visual.dart`:**
    *   Grid layout for skills.
    *   Slots: `List<Widget> skillsSlot`.
*   **`home_footer_visual.dart`:**
    *   Footer content, copyright, and contact links.

### 2. Unit Widgets
*   **`home_skill_card_unit.dart`:**
    *   Displays a single skill/expertise item.
    *   Input: `SkillVM` (Title, Icon, Description).
*   **`home_social_button_unit.dart`:**
    *   Wrapper/Standardizer for social icon buttons if needed (or just use `KitIconButton` directly in slots).

### 3. Integration
*   Update the `CustomScrollView` in platform files to include these new sections in the correct order.

---

## Phase 3: Interactivity & Final Polish
**Goal:** Add navigation, drawer interactions, and connect distinct actions.

### 1. Controls (Local State)
*   **`home_mobile_menu_control.dart`:**
    *   Manages the open/closed state of the mobile navigation drawer.

### 2. Actions (Intent Emitters)
*   **`home_read_article_action.dart`:** Dispatches event to open article drawer.
*   **`home_open_link_action.dart`:** Handles external URL launching.
*   **`home_scroll_to_section_action.dart`:** Handles scrolling to anchors.

### 3. Views (State Listeners)
*   **`home_article_drawer_view.dart`:**
    *   The overlay reader for articles.
    *   Listens to global/page state to show/hide.

### 4. Final Assembly
*   Replace mock buttons with actual Action widgets.
*   Connect the Mobile Menu Control.
*   Final responsive adjustments using `ScreenSizeBuilder` or `LayoutBuilder` within Visuals where necessary.
