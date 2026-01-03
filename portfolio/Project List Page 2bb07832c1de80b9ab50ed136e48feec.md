# Project List Page

**Screen Name:** `ProjectListScreen`

**Purpose:**

- Displays a comprehensive grid of all projects (mobile apps, open-source, etc.).
- Allows users to browse the full archive beyond the "Featured" selection on the homepage.

**Entry Point:**

- From `HomeScreen` (via "Show More Projects").

**Exit Point:**

- **Internal:** `ProjectDetailScreen` (Forward), `HomeScreen` (Back).
- **External:** GitHub (Source Code), Mailto (FAB).

**Access Level:** Public

**Dynamic Content Inventory:**

1. **Page Header**
    - `page.title` ("My Project Archive")
    - `page.subtitle`
2. **Projects Grid (List)**
    - `project.title`
    - `project.typeIcon` (Material Symbol, e.g., 'smartphone', 'rocket_launch')
    - `project.description`
    - `project.coverImageAsset` (Local Asset)
    - `project.tags` (List: Flutter, Web3, Rive, etc.)
    - `project.sourceUrl` (GitHub)

<aside>
💡

### Step 2A: Datasource & Automatic Logic Specifications

### ⚡ `init_loadAllProjects` Specification (Lifecycle)

1. **Action Definition & Logic**
    - **Action ID:** `init_loadAllProjects`
    - **Trigger:** `initState`
    - **Prerequisites:** None
    - **Method:** `fetchAllProjects()`
    - **Raw Inputs:** None
    - **Raw Outputs:** `List<Project>` (Complete archive)
    - **Purpose:** To fetch and display the complete list of projects available in the portfolio.
2. **UI State Machine**
    - **Idle:** Empty Grid.
    - **Loading:** Skeleton Grid.
    - **Success:** Render full grid of project cards.
    - **Error:** Display "Failed to load archive" with retry button.
    - **Network Issue:** Load from Hive cache if available.

---

### ⚡ `logic_openRepo` Specification (Logic)

1. **Action Definition & Logic**
    - **Action ID:** `logic_openRepo`
    - **Trigger:** Tap (GitHub Icon on Project Card)
    - **Prerequisites:** Valid `sourceUrl`.
    - **Method:** `launchUrl(project.sourceUrl)`
    - **Raw Inputs:** `url` (String)
    - **Raw Outputs:** Boolean
    - **Purpose:** Opens the specific project's source code in the browser.
2. **UI State Machine**
    - **Idle:** Icon visible.
    - **Loading:** System-handled.
    - **Success:** Browser opens.
    - **Error:** Toast: "Invalid repository link."

---

### ⚡ `logic_sendEmail` Specification (Logic)

1. **Action Definition & Logic**
    - **Action ID:** `logic_sendEmail`
    - **Trigger:** Tap (FAB)
    - **Prerequisites:** None
    - **Method:** `launchUrl('mailto:...')`
    - **Raw Inputs:** None
    - **Raw Outputs:** Boolean
    - **Purpose:** Initiates an email to the contact address.
2. **UI State Machine**
    - **Idle:** FAB visible.
    - **Loading:** System-handled.
    - **Success:** Email app opens.
    - **Error:** Toast: "No email client found."
</aside>

<aside>
💡

### `nav_openProjectDetail` Specification (Navigation)

1. **Identity & Strategy**
    - **Trigger:** Tap Project Card (Image/Title) **OR** "Download App" button.
    - **Route:** `ProjectListScreen` → `ProjectDetailScreen`
    - **Stack Action:** Push
2. **Data Contract**
    - **Args Passed:** `projectId` (String)
    - **Return Data:** None
3. **Implementation Directives**
    - Passes the ID to load specific project data.

---

### 🧭 `nav_goBack` Specification (Navigation)

1. **Identity & Strategy**
    - **Trigger:** Tap "Back to Portfolio" link or Top-Left Back Arrow.
    - **Route:** `ProjectListScreen` → `HomeScreen`
    - **Stack Action:** Pop
2. **Data Contract**
    - **Args Passed:** None
    - **Return Data:** None
3. **Implementation Directives**
    - Returns the user to the previous state of the Homepage.

---

### 

</aside>