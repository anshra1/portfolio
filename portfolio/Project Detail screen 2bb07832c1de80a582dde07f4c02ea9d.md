# Project Detail screen

**Screen Name:** `ProjectDetailScreen`

**Purpose:**

- Showcases the full technical depth of a single project.
- Provides direct access to source code, binary downloads, and store links.
- Explains the system architecture and tech stack.

**Entry Point:**

- From `HomeScreen` (Featured Project) or `ProjectListScreen` (Archive).

**Exit Point:**

- **Internal:** Back navigation.
- **External:** GitHub, App Stores (iOS/Android), Direct Downloads (Desktop).

**Access Level:** Public

**Dynamic Content Inventory:**

1. **Header & Hero**
    - `project.title` (e.g., "SyncFlow")
    - `project.tagline` (e.g., "Real-time task synchronization engine.")
    - `project.heroImageAsset`
2. **Overview**
    - `project.longDescription` (HTML/Markdown supported text)
    - `project.techStack` (List of strings: "Flutter", "WebSockets", "Redis", etc.)
3. **Source Action**
    - `project.sourceUrl`
4. **Downloads / Platforms (List)**
    - `platform.name` (Windows, macOS, Linux, iOS, Android)
    - `platform.version` (e.g., "1.2.0")
    - `platform.meta` (Size: "85 MB" or Requirement: "iOS 15+")
    - `platform.actionUrl` (Download link or Store URL)
    - `platform.type` (Enum: Binary, Store)
5. **System Architecture (List)**
    - `feature.title` (e.g., "WebSocket Layer")
    - `feature.description`
    - `feature.icon` (SVG/IconData)

<aside>
💡

### Step 2A: Datasource & Automatic Logic Specifications

### ⚡ `init_loadProjectDetails` Specification (Lifecycle)

1. **Action Definition & Logic**
    - **Action ID:** `init_loadProjectDetails`
    - **Trigger:** `initState`
    - **Prerequisites:** `projectId` passed from previous screen.
    - **Method:** `fetchProjectDetails(String id)`
    - **Raw Inputs:** `projectId`
    - **Raw Outputs:** `ProjectDetail` object (includes `techStack`, `downloadLinks`, `architectureFeatures`)
    - **Purpose:** To fetch the specific deep-dive content for the selected project.
2. **UI State Machine**
    - **Idle:** Blank/Skeleton.
    - **Loading:** Skeleton loader on Text and Image blocks.
    - **Success:** Render Hero, Description, Stack, GitHub Button, Download Grid, Architecture Grid.
    - **Error:** "Project not found" or "Connection error".

---

### ⚡ `logic_openSourceCode` Specification (Logic)

1. **Action Definition & Logic**
    - **Action ID:** `logic_openSourceCode`
    - **Trigger:** Tap "View Source on GitHub" button.
    - **Prerequisites:** Valid URL.
    - **Method:** `launchUrl(project.sourceUrl)`
    - **Raw Inputs:** `url`
    - **Raw Outputs:** Boolean
    - **Purpose:** Open the code repository.
2. **UI State Machine**
    - **Idle:** Button visible.
    - **Success:** Browser launch.

---

### ⚡ `logic_downloadArtifact` Specification (Logic)

1. **Action Definition & Logic**
    - **Action ID:** `logic_downloadArtifact`
    - **Trigger:** Tap "Download .exe" / "Download .dmg" / "Download .AppImage".
    - **Prerequisites:** Valid binary file URL.
    - **Method:** `launchUrl(platform.downloadUrl, mode: externalApplication)`
    - **Raw Inputs:** `url`
    - **Raw Outputs:** Boolean
    - **Purpose:** Triggers the browser/OS download manager for desktop binaries.
2. **UI State Machine**
    - **Idle:** Card visible.
    - **Success:** Browser/Download Manager opens.

---

### ⚡ `logic_openAppStore` Specification (Logic)

1. **Action Definition & Logic**
    - **Action ID:** `logic_openAppStore`
    - **Trigger:** Tap "App Store" / "Google Play" button.
    - **Prerequisites:** Valid Store URL.
    - **Method:** `launchUrl(platform.storeUrl)`
    - **Raw Inputs:** `url`
    - **Raw Outputs:** Boolean
    - **Purpose:** Deep links to the specific app store listing for mobile platforms.
</aside>

<aside>
💡

### 🧭 `nav_goBack` Specification (Navigation)

1. **Identity & Strategy**
    - **Trigger:** System Back Button or AppBar Back Arrow.
    - **Route:** `ProjectDetailScreen` → Previous Screen (`HomeScreen` or `ProjectListScreen`).
    - **Stack Action:** Pop
2. **Data Contract**
    - **Args Passed:** None
    - **Return Data:** None
3. **Implementation Directives**
    - Standard history pop.
</aside>