# Plain-English Method Design Shell: getProjectDetail

## 1. Project Feature Name

**Projects Feature**

**Role:**
Allows users to discover, filter, and view the portfolio's body of work. This method enables deep inspection of a single project's details.

## 2. Method Name

`getProjectDetail`

**Role:**
A specialized data recovery method that retrieves the full technical representation of a specific project by its ID. It is primarily used to restore application state during deep linking or browser refreshes.

## 3. Method Responsibility

**Role:**
Defines exactly what the method is accountable for.

*   **Retrieve** a specific project record from the local data store using its unique identifier.
*   **Validate** the input identifier.
*   **Map** technical I/O exceptions (Missing File, Malformed JSON, Not Found, Partial Data) to Domain Failures.
*   **Normalize** the data to ensure optional collections (downloads, features) are safe for UI consumption (never null).

## 4. Datasource (The Mechanism)

**Focus:** Pure IO interaction, JSON Parsing, Record Lookup, and Strict Serialization.

### 4.1 Full Method Working (Plain English)

**Step 1:** Check if the projects list is already cached in memory.
   *   **1a (Cached):** Use the existing list.
   *   **1b (Not Cached):** Load `assets/data/projects.json`, parse it, skip corrupt records (Valid-Subset Recovery), and cache the result.
**Step 2:** Search the list for the first `ProjectModel` where `id` matches `projectId`.
   *   **2a (Found):** Return the `ProjectModel`.
   *   **2b (Not Found):** Throw `NotFoundException`.
       *   *Note:* If a project exists in the file but is corrupt (missing mandatory fields), it was skipped during Step 1. Therefore, it will effectively be treated as "Not Found" here.

### 4.2 Context & Inputs

**Services:**
*   `AssetBundle` (or `rootBundle`): To read the file.

**Data:**
*   File Path: `assets/data/projects.json`.
*   Input: `String projectId`.

### 4.3 Edge Cases

*   **Missing Asset File:** The `assets/data/projects.json` file is physically missing.
    *   *Behavior:* Catch `FileSystemException`, Throw `DataParsingException` (Graceful Failure).
*   **Malformed JSON Syntax:** The file content is invalid JSON.
    *   *Behavior:* Catch `FormatException`, Throw `DataParsingException` (Strict Failure).
*   **Partial Schema Violation:** The requested record exists but is missing mandatory fields.
    *   *Behavior:* Throw `NotFoundException` (Relaxed Contract: Corrupt data is treated as missing).
*   **Project Not Found:** The valid ID does not exist in the dataset.
    *   *Behavior:* Throw `NotFoundException`.

### 4.4 Architectural Decisions

*   **In-Memory Caching:** Reuses the cached list from `getProjects` to avoid redundant parsing.
*   **Relaxed Contract:** We treat corrupt records as "Not Found" rather than throwing a parsing error. This ensures that a single bad record doesn't prevent looking up other valid records.
*   **Datasource Lookup:** The responsibility of iterating the list is delegated to the Datasource.

### 4.5 Test Cases

**Test Case ID: DS-DET-001**
*   **Category:** Datasource
*   **Scenario:** Successful retrieval of a valid project by ID.
*   **Preconditions:** The `assets/data/projects.json` file exists and contains a JSON list with a valid project object having `id="p1"`.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Returns a `ProjectModel` object where the `id` field matches "p1" and all other fields match the JSON content.
*   **Traceability:** Datasource Step 2a.

**Test Case ID: DS-DET-002**
*   **Category:** Datasource
*   **Scenario:** Project not found in the dataset.
*   **Preconditions:** The `assets/data/projects.json` file exists but does NOT contain any object with `id="unknown"`.
*   **Action:** Call `getProjectDetail("unknown")`.
*   **Expected Outcome:** Throws `NotFoundException`.
*   **Traceability:** Datasource Step 2b, Edge Case: Project Not Found.

**Test Case ID: DS-DET-003**
*   **Category:** Datasource
*   **Scenario:** Asset file missing from bundle.
*   **Preconditions:** The `assets/data/projects.json` file is physically missing or inaccessible.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Throws `DataParsingException`.
*   **Traceability:** Edge Case: Missing Asset File.

**Test Case ID: DS-DET-004**
*   **Category:** Datasource
*   **Scenario:** Malformed JSON syntax in asset file.
*   **Preconditions:** The `assets/data/projects.json` file contains invalid JSON text (e.g., missing closing brace).
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Throws `DataParsingException`.
*   **Traceability:** Edge Case: Malformed JSON Syntax.

**Test Case ID: DS-DET-005**
*   **Category:** Datasource
*   **Scenario:** Relaxed Contract - Missing mandatory fields.
*   **Preconditions:** The `assets/data/projects.json` file contains a project with `id="p1"` but is missing the mandatory `title` field.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Throws `NotFoundException` (The invalid record is skipped, so ID "p1" is not found in the valid list).
*   **Traceability:** Datasource Step 1, Step 2b, Edge Case: Partial Schema Violation.

## 5. Repository (The Policy)

**Focus:** Coordination, Validation, Error Translation, and Data Normalization.

### 5.1 Full Method Working (Plain English)

**Step 1:** **Validate Input:**
   *   Check if `projectId` is empty or null.
   *   If invalid, return `Left(ValidationFailure)`.

**Step 2:** **Fetch Data:**
   *   Call the Datasource's `getProjectDetail(projectId)` method.
   *   *Concurrency Note:* Standard platform async handling is used; no explicit debounce logic is applied.

**Step 3:** **Handle Exceptions (Try/Catch):**
   *   Catch `NotFoundException` → Return `Left(NotFoundFailure)`.
   *   Catch `DataParsingException` → Return `Left(DataParsingFailure)`.
   *   Catch generic `Exception` → Return `Left(UnknownFailure)`.

**Step 4:** **Normalize & Return:**
   *   Receive the `ProjectModel`.
   *   Convert it to a `Project` entity using `.toEntity()`.
   *   *Normalization Rule:* Ensure that if `downloads` or `features` lists are null in the model, they are converted to empty lists `[]` in the entity.
   *   Return `Right(Project)`.

### 5.2 Context & Inputs

**Services:**
*   `ProjectsRemoteDataSource`: To perform the actual lookup.

**Data:**
*   Input: `String projectId`.

### 5.3 Edge Cases

*   **Empty/Null Input ID:** Caller passes an invalid string.
    *   *Behavior:* Return `Left(ValidationFailure)` immediately.
*   **Concurrency:** Multiple rapid calls.
    *   *Behavior:* Allow platform to handle parallel read operations (Stateless I/O).

### 5.4 Architectural Decisions

*   **Strict Error Mapping:** The Repository converts technical exceptions into semantic domain failures (`NotFoundFailure`) for the UI.
*   **Deep Link Recovery:** This method is explicitly designed for "cold start" scenarios.

### 5.5 Test Cases

**Test Case ID: REP-DET-001**
*   **Category:** Repository
*   **Scenario:** Input Validation - Empty ID.
*   **Preconditions:** None.
*   **Action:** Call `getProjectDetail("")`.
*   **Expected Outcome:** Returns `Left(ValidationFailure)`.
*   **Traceability:** Repository Step 1, Edge Case: Empty/Null Input ID.

**Test Case ID: REP-DET-002**
*   **Category:** Repository
*   **Scenario:** Input Validation - Null ID.
*   **Preconditions:** None.
*   **Action:** Call `getProjectDetail(null)` (if permitted by language).
*   **Expected Outcome:** Returns `Left(ValidationFailure)`.
*   **Traceability:** Repository Step 1.

**Test Case ID: REP-DET-003**
*   **Category:** Repository
*   **Scenario:** Successful delegation and normalization.
*   **Preconditions:** Datasource returns a valid `ProjectModel` with `id="p1"`.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Returns `Right(Project)` where the entity's ID is "p1".
*   **Traceability:** Repository Step 2, Step 4.

**Test Case ID: REP-DET-004**
*   **Category:** Repository
*   **Scenario:** Data Normalization - Null optional lists.
*   **Preconditions:** Datasource returns a `ProjectModel` where `downloads` and `features` are `null`.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Returns `Right(Project)` where `downloads` and `features` are empty lists `[]` (not null).
*   **Traceability:** Repository Step 4 (Normalization Rule).

**Test Case ID: REP-DET-005**
*   **Category:** Repository
*   **Scenario:** Mapping NotFound Exception.
*   **Preconditions:** Datasource throws `NotFoundException`.
*   **Action:** Call `getProjectDetail("p999")`.
*   **Expected Outcome:** Returns `Left(NotFoundFailure)`.
*   **Traceability:** Repository Step 3, Edge Case: Project Not Found.

**Test Case ID: REP-DET-006**
*   **Category:** Repository
*   **Scenario:** Mapping DataParsing Exception.
*   **Preconditions:** Datasource throws `DataParsingException`.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Returns `Left(DataParsingFailure)`.
*   **Traceability:** Repository Step 3, Edge Case: Malformed JSON / Schema Violation.

**Test Case ID: REP-DET-007**
*   **Category:** Repository
*   **Scenario:** Mapping Generic Server Failure.
*   **Preconditions:** Datasource throws a generic `Exception`.
*   **Action:** Call `getProjectDetail("p1")`.
*   **Expected Outcome:** Returns `Left(UnknownFailure)`.
*   **Traceability:** Repository Step 3.

**Test Case ID: REP-DET-008**
*   **Category:** Repository
*   **Scenario:** Concurrency (Statelessness).
*   **Preconditions:** Two simultaneous calls are made to `getProjectDetail`.
*   **Action:** Execute both calls concurrently.
*   **Expected Outcome:** Both calls complete independently (No shared state interference).
*   **Traceability:** Repository Step 2 (Concurrency Note).

## 6. Full Working Flow (Datasource → Repository)

**Step 1:** The UI (Page or Bloc) detects a missing project object (e.g., from a deep link) and calls `repository.getProjectDetail("p1")`.
**Step 2:** The Repository validates the ID "p1".
**Step 3:** The Repository delegates the call to the Datasource.
**Step 4:** The Datasource reads the JSON file, parses it, finds the record with ID "p1", validates its schema (strict check), and returns the `ProjectModel`.
**Step 5:** The Repository catches any errors (mapping "Not Found" if necessary).
**Step 6:** The Repository converts the Model to an Entity, ensuring all lists are safe (non-null).
**Step 7:** The Repository returns `Right(Project)` to the UI for display.

## 7. Notes

*   **Performance:** Loading and parsing the entire JSON file for a single lookup is acceptable given the small dataset size (Portfolio scale).
*   **Navigation Optimization:** Standard navigation from the list view should bypass this method and pass the existing `Project` object directly to avoid this I/O overhead.
