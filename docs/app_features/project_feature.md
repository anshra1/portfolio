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
- `isFeatured`: Boolean — **Logic:** Controls visibility on `HomeScreen` (Featured vs Archive).
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

JSON

# 

`{
  "id": "p1",
  "isFeatured": true,
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
}`

## Scope

### In Scope

* Display featured projects on the homepage
* Display the full archive of projects
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

---

### ProjectDetail

Represents the deep technical view of a project.

Responsibilities:

* Expose full descriptive content (rich text)
* Provide tech stack and architecture highlights
* Provide downloadable artifacts and store links
* Act as the authoritative representation of a project

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

* Fake pagination: the complete dataset is returned in one request
* Paging parameters exist only to preserve API shape

### Filtering & Sorting Policy

* Supported filters:
  * Search query (title + tagline + description)
  * Technology selection
  * Sort order (Enum: Newest, Oldest, Popular)
  * Featured selection (isFeatured)

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

## Feature-Level Failures

* NetworkFailure
* ServerFailure
* DataParsingFailure
* NotFoundFailure
* PlatformFailure
* ValidationFailure

---

## Method Specifications

### Method: getProjects

**Purpose (Detailed)**
Provide a discoverable list of projects that communicates the breadth and nature of the work. This method serves as the single entry point for all project list contexts, including featured projects and the full archive.

It ensures that the UI receives a fully-prepared list suitable for direct rendering without additional business logic.

---

**Input**

* `filter` (ProjectFilter)

**Output**

* `List<Project>`

---

**Inherited Feature Decisions**

* Fake pagination
* No cache
* Fail-fast offline

---

**High-Level Functional Flow**

1. Validate the filter parameters
2. Retrieve the complete project dataset
3. Apply search filtering if a query is present
4. Apply technology filtering if selected
5. Apply featured filtering if requested
6. Apply sorting based on the selected order
7. Return the resulting project list to the caller

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

* Sorting or ranking projects
* Tag-based filtering

---

### Method: getProjectDetail

**Purpose (Detailed)**
Retrieve the complete technical and descriptive representation of a single project. This method supports deep inspection of implementation details and architectural choices.

It guarantees that the UI receives a fully-formed project object that can be rendered without defensive checks.

---

**Input**

* `projectId` (String)

**Output**

* `ProjectDetail`

---

**Inherited Feature Decisions**

* No cache
* Fail-fast offline

---

**High-Level Functional Flow**

1. Validate the project identifier
2. Locate the project matching the identifier
3. Load all extended fields and related data
4. Normalize optional collections to safe defaults
5. Return the complete project detail

---

**Edge Cases**

* Empty or malformed project ID
* Project exists but optional fields are missing

---

**Failures**

* ValidationFailure
* NotFoundFailure
* NetworkFailure
* DataParsingFailure

---

**Non-Goals**

* Prefetching related projects
* Cross-project navigation

---


## Final Notes

* This feature must not depend on Articles or Home feature logic
* All business logic must remain outside the UI layer

