# Article List Screen

**Screen Name:** `ArticleListScreen`

**Purpose:**

- A searchable, filterable repository of all writing and tutorials.
- Allows users to find specific topics via tags or keywords and browse chronologically or by popularity.

**Entry Point:**

- From `HomeScreen` (via "View All Learnings").

**Exit Point:**

- **Internal:** `ArticleDetailScreen` (Forward), `HomeScreen` (Back).

**Access Level:** Public

**Dynamic Content Inventory:**

1. **Filter State**
    - `filter.searchQuery` (String)
    - `filter.selectedTag` (String, nullable)
    - `filter.sortOrder` (Enum: Newest, Oldest, Popular)
2. **Tag List**
    - `tags` (List of Strings: #workflow, #flutter, #design, etc.)
3. **Article Grid (List)**
    - `article.title`
    - `article.date`
    - `article.readTime`
    - `article.tags`
    - `article.coverImageAsset`
    - `article.summary`

<aside>
💡

### 1. Logic & Lifecycle Actions

**⚡ `init_loadInitialArticles` Specification (Lifecycle)**

- **Action ID:** `init_loadInitialArticles`
- **Trigger:** `initState` (Screen Load)
- **Prerequisites:** None
- **Method:** `fetchArticles(page: 1, filters: default)`
- **Raw Inputs:** None
- **Raw Outputs:** `ArticleListResponse` (List of Articles + List of Tags)
- **Purpose:** To fetch the initial paginated list of articles and populate the tag dropdown options.
- **UI State Machine:**
    - **Idle:** Skeleton Loader / Shimmer.
    - **Success:** Render Grid and enable Filter Controls.
    - **Error:** Show "Retry" button.

**⚡ `logic_refreshArticleList` Specification (Logic)**

- **Action ID:** `logic_refreshArticleList`
- **Trigger:** `ui_modifyFilterState` (User typed in search, selected tag, or changed sort).
- **Prerequisites:** Updated Filter State.
- **Method:** `fetchArticles(query, tag, sortOrder)`
- **Raw Inputs:** `filterState` object.
- **Raw Outputs:** `List<Article>` (Filtered & Sorted).
- **Purpose:** The central logic that retrieves the list based on *current* UI criteria. It handles searching, tagging, and sorting in a single efficient query.
- **UI State Machine:**
    - **Loading:** List Opacity drops / Loading Indicator.
    - **Success:** List updates with new results.
    - **Empty:** "No articles found" message.

**⚡ `logic_loadMoreArticles` Specification (Logic)**

- **Action ID:** `logic_loadMoreArticles`
- **Trigger:** Scroll Position reaches bottom threshold (Infinite Scroll).
- **Prerequisites:** `hasMorePages` is true && `isLoading` is false.
- **Method:** `fetchArticles(page: currentPage + 1)`
- **Raw Inputs:** `currentPage` index.
- **Raw Outputs:** `List<Article>` (Next Page).
- **Purpose:** To append the next batch of articles to the existing list for seamless browsing.
- **UI State Machine:**
    - **Loading:** Show small spinner at footer.
    - **Success:** Append items to grid.

---

### 2. Pure UI Actions

**🎨 `ui_modifyFilterState` Specification (Pure UI)**

- **Action ID:** `ui_modifyFilterState`
- **Trigger:**
    - Type in **Search Bar**.
    - Tap **Tag** in Dropdown (e.g., #flutter, #design).
    - Tap **Sort Button** (Newest, Oldest, Popular).
- **Idle:** Current State.
- **Active:** Updates local `filterState` variables.
- **Purpose:** Immediately updates the UI controls (highlight active tag/sort button) and calls `logic_refreshArticleList`.

**🎨 `ui_toggleTagMenu` Specification (Pure UI)**

- **Action ID:** `ui_toggleTagMenu`
- **Trigger:** Tap "Browse all tags" button.
- **Idle:** Tag Menu hidden.
- **Active:** Tag Menu visible (dropdown/drawer).
- **Purpose:** Reveals the list of available hashtags for filtering.

**🎨 `ui_toggleTheme` Specification (Pure UI)**

- **Action ID:** `ui_toggleTheme`
- **Trigger:** Tap "Toggle Theme" button.
- **Idle:** Current Theme (e.g., Light).
- **Active:** Inverse Theme (e.g., Dark).
- **Purpose:** Switches the global visual theme of the application.

---

### 3. Navigation Actions

**🧭 `nav_openArticleDetail` Specification (Navigation)**

- **Trigger:** Tap Article Card (Image or Title).
- **Route:** `ArticleListScreen` → `ArticleDetailScreen`
- **Stack Action:** Push
- **Args Passed:** `articleId` (String)
- **Implementation:** Passes ID to load full content on the next screen.

**🧭 `nav_goBack` Specification (Navigation)**

- **Trigger:** System Back Button.
- **Route:** `ArticleListScreen` → `HomeScreen`
- **Stack Action:** Pop
- **Args Passed:** None
- **Implementation:** Standard history pop.
</aside>