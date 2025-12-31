# Feature: Projects

## Intent

The Projects feature represents the core body of work in the portfolio. It allows users to discover, explore, and inspect projects at varying depths—from high-level summaries to detailed technical breakdowns.

The feature is designed to communicate technical credibility and showcase implementation depth without allowing modification or interaction with the data itself.

---
### Data Model: Project

Definition:

The core portfolio entity. Represents a specific work item (App, Library, Proof-of-Concept).

**1. Core Fields (Traceability)**

- `id`: String — **Logic:** Unique identifier for routing.
- `displayTier`: Enum (Hero, Showcase, Standard, Hidden) — **Logic:** Controls ranking and visibility hierarchy.
- `publishedAt`: DateTime — **Logic:** Used for chronological sorting and secondary ranking.
- `title`: String — **UI:** Displayed on Card and Header.
- `tagline`: String — **UI:** Short subtitle for the Detail Screen hero section.
- `typeIcon`: String — **UI:** Material Symbol name (e.g., 'smartphone', 'groups').
- `coverImageAsset`: String — **UI:** Local asset path for the cover image.
- `sourceUrl`: URL — **Logic:** Used by `logic_openSourceCode`.
- `description`: HTML/String — **UI:** Truncated on Cards; full text on Detail Screen.
- `technologies`: List<String> — **UI:** Combined tags and tech stack (First 3 on Cards, full list on Detail).

**2. Relationships**

- Has Many → `DownloadableArtifact`
- Has Many → `ArchitectureFeature`

**3. Mock Data Structure (JSON)**

```json
{
  "id": "p1",
  "displayTier": "hero",
  "publishedAt": "2024-01-15T10:00:00Z",
  "title": "SyncFlow",
  "tagline": "Real-time task synchronization engine.",
  "typeIcon": "smartphone",
  "coverImageAsset": "assets/images/projects/syncflow_cover.jpg",
  "sourceUrl": "https://github.com/username/syncflow",
  "description": "<p>Modern productivity users expect their data to be available everywhere...</p>",
  "technologies": ["Flutter", "WebSockets", "CRDTs", "Node.js", "Redis"],
  "downloads": [
    {
      "platformName": "Windows",
      "version": "1.2.0 (x64)",
      "metaInfo": "Size: 85 MB",
      "type": "Binary",
      "actionUrl": "https://example.com/downloads/syncflow-win.exe"
    }
  ],
  "features": [
    {
      "title": "WebSocket Layer",
      "description": "Persistent bi-directional connection...",
      "icon": "assets/icons/websocket.svg"
    }
  ]
}
```

## Scope

### In Scope

* Display featured projects (Hero/Showcase tiers) on the homepage
* Display the full archive of projects with ranked sorting
* Load detailed technical information for a single project
* Allow users to open source repositories
* Allow users to download binaries or open app store listings

### Out of Scope

* Creating, editing, or deleting projects
* User authentication
* Analytics or tracking
* Offline-first support
* Background downloads

---

## Feature-Owned Entities

### Project

Represents a project in list and summary contexts.

Responsibilities:

* Provide identity for routing and lookup
* Expose metadata for discovery and overview
* Support lightweight rendering in grids and cards
* **Computed Logic:** Expose `isFeatured` getter (Hero || Showcase) for UI convenience.
* **Implementation Note:** Implemented as a **Unified Model** (Single `Project` entity) to simplify the architecture.

---

### ProjectDetail

Represents the deep technical view of a project.

Responsibilities:

* Expose full descriptive content (rich text)
* Provide tech stack and architecture highlights
* Provide downloadable artifacts and store links
* Act as the authoritative representation of a project
* **Implementation Note:** Implemented as a **Unified Model** (Single `Project` entity) covering both summary and detailed fields.

---

## Public Methods (Feature API)

* `getProjects({ProjectFilter filter})`
* `getProjectDetail(String projectId)`


---

## Feature-Level Architectural Decisions

### Data Source Strategy

* Data is loaded from a simulated remote source (local JSON assets)
* All reads are asynchronous

### Pagination Policy

* Infinite Scroll: Data is loaded in chunks
* The API returns a subset of items based on `page` and `limit`
* An empty list signifies the end of the dataset

### Filtering & Sorting Policy

* **Ranked Search Algorithm:**
  1.  **Primary Sort:** `DisplayTier` (Hero > Showcase > Standard)
  2.  **Secondary Sort:** `publishedAt` (Newest > Oldest)
* **Supported Filters:**
  * Search query (title + tagline + description)
  * Technology selection
  * **Featured Request:** (Logic: Maps `filter.isFeatured` to `Hero` & `Showcase` tiers)

### Caching Policy

* No persistent cache
* No in-memory reuse across calls

### Offline Behavior

* Fail-fast: offline state immediately returns a failure

### Error Handling Model

* All public methods return `Result<T, Failure>`
* Technical exceptions are mapped to domain failures

### Performance Constraints

* Project dataset is expected to remain small (portfolio scale)
* Parsing and mapping are acceptable on the main thread

---



---

## Method Specifications

### Method: getProjects

**Purpose (Detailed)**
Provide a discoverable list of projects that communicates the breadth and nature of the work. This method serves as the single entry point for all project list contexts.

It guarantees a **Ranked List** where the most important work (Hero Tier) is always presented first, regardless of search queries or date, unless specifically sorted otherwise.

---

**Input**

* `page` (int)
* `limit` (int, optional)
* `filter` (ProjectFilter)

**Output**

* `List<Project>`

---

**Inherited Feature Decisions**

* Infinite Scroll (Chunk-based loading)
* No cache
* Fail-fast offline

---

**Data**

* Retrieve the complete project dataset from the local JSON asset
* Parse the raw JSON into domain entities

**Data Repository**

* **Role:** Logic Engine & Pagination
* Applies **Ranked Sorting** logic in-memory.
* Maps high-level filter requests (like `isFeatured`) to specific semantic tiers.
* Slices the list based on `page` and `limit`.

---

**High-Level Functional Flow**

1. Validate the filter parameters
2. Retrieve the complete project dataset
3. Apply search filtering if a query is present
4. Apply technology filtering if selected
5. **Apply Tier Filtering:** If `filter.isFeatured` is true, restrict to `Hero` and `Showcase` tiers.
6. **Apply Ranked Sorting:**
    *   Sort by Tier Index (Hero first)
    *   Sort by Date (Newest first)
7. Apply pagination (slice the list based on page and limit)
8. Return the resulting project list to the caller

---

**Edge Cases**

* No projects exist in the dataset
* No featured projects are available

---

**Failures**

* NetworkFailure
* ServerFailure
* DataParsingFailure

---

**Non-Goals**

* Tag-based filtering (beyond technology)

---

### Method: getProjectDetail

**Purpose (Detailed)**
Retrieve the complete technical and descriptive representation of a single project.
*   **Primary Role:** **Data Recovery & Deep Link Handler**.
*   **Context:** Used primarily when the application state is empty (e.g., Browser Refresh or Direct URL entry). Standard navigation should pass the `Project` object directly.
*   **Guarantee:** Returns a fully hydrated `Project` entity with all optional collections normalized to safe defaults.

---

**Input**

* `projectId` (String)

**Output**

* `Project` (Unified Model)

---

**Inherited Feature Decisions**

* No cache
* Fail-fast offline

---

**Data**

* **Datasource Role:** Pure I/O & Lookup.
* Accesses the local JSON asset and iterates internally to find the specific record.
* Throws exceptions if not found or if parsing fails.

**Data Repository**

* **Role:** Coordination & Error Mapping.
* Delegates the lookup to the Datasource.
* Converts technical exceptions into Domain Failures.
* Normalizes the returned model (e.g., ensuring null lists become empty lists).

---

**High-Level Functional Flow**

1. Validate the project identifier (check for non-empty)
2. Call the Datasource to fetch the specific project by ID
3. **Success:**
    *   Normalize optional fields
    *   Map Model to Entity
    *   Return `Right(Project)`
4. **Failure:**
    *   Map `NotFoundException` → `Left(NotFoundFailure)`
    *   Map `DataParsingException` → `Left(DataParsingFailure)`
    *   Map other errors → `Left(ServerFailure)`

---

**Edge Cases**

* Invalid ID (empty/null)
* Project ID not found in dataset

---

**Failures**

* ValidationFailure
* NotFoundFailure
* DataParsingFailure
* ServerFailure

---

**Non-Goals**

* Prefetching related projects
* Cross-project navigation

---


## Final Notes

* This feature must not depend on Articles or Home feature logic
* All business logic must remain outside the UI layer