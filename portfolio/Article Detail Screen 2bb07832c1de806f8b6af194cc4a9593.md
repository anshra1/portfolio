# Article Detail Screen

**Screen Name:** `ArticleDetailScreen`

**Purpose:**

- Displays the full read-mode content of a specific blog post or tutorial.
- Provides a distraction-free reading environment with a call-to-action to view the portfolio.

**Entry Point:**

- From `HomeScreen` or `ArticleListScreen`.

**Exit Point:**

- **Internal:** `ArticleListScreen` (Back), `HomeScreen` (CTA).
- **External:** None explicit in the markup (Hyperlinks in prose handled by system).

**Access Level:** Public

**Dynamic Content Inventory:**

1. **Header Metadata**
    - `article.tags` (List: #UI/UX, #Flutter)
    - `article.title`
    - `article.authorName`
    - `article.publishDate`
    - `article.readTime`
2. **Main Content**
    - `article.coverImageAsset`
    - `article.contentBody` (Rich Text / HTML string)
3. **Footer CTA**
    - Static text ("Enjoyed this insight? Check out my other projects...").

<aside>
💡

### Logic & Lifecycle Actions

**⚡ `init_loadArticleContent` Specification (Lifecycle)**

- **Action ID:** `init_loadArticleContent`
- **Trigger:** `initState`
- **Prerequisites:** `articleId` passed from list.
- **Method:** `fetchArticleDetails(String id)`
- **Raw Inputs:** `articleId`
- **Raw Outputs:** `Article` object (containing `contentBody` as HTML/Markdown string).
- **Purpose:** Fetches the full content, metadata, and assets for the specific article to be rendered.
- **UI State Machine:**
    - **Idle:** Blank.
    - **Loading:** Skeleton Text paragraphs.
    - **Success:** Render Rich Text content.
    - **Error:** "Article not found."

---

### 2. Navigation Actions

**🧭 `nav_goBackToArticles` Specification (Navigation)**

- **Trigger:** Tap "Back to Articles" link (Navbar).
- **Route:** `ArticleDetailScreen` → `ArticleListScreen` (or previous).
- **Stack Action:** Pop
- **Args Passed:** None
- **Implementation:** Standard history pop.

**🧭 `nav_viewProjectsCTA` Specification (Navigation)**

- **Trigger:** Tap "View My Projects" button (Bottom CTA).
- **Route:** `ArticleDetailScreen` → `HomeScreen`
- **Stack Action:** Pop (if Home is in stack) OR Push replacement.
- **Args Passed:** None
- **Implementation:** Per the MMD flow, this routes the user back to the Portfolio/Home context.

---

### 3. Pure UI Actions

**🎨 `ui_toggleTheme` Specification (Pure UI)**

- **Action ID:** `ui_toggleTheme`
- **Trigger:** Tap Theme Icon.
- **Idle:** Current Theme.
- **Active:** Inverse Theme.
- **Purpose:** Switches the reader view between Light and Dark modes for accessibility/preference.
</aside>