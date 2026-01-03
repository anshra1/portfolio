# Plain-English Method Design Shell: getArticleDetail

## 1. Project Feature Name

**Articles Feature**

**Role:**
Provides a structured, searchable, and readable knowledge base for blog posts and tutorials. This method enables deep inspection of a single article's full content.

## 2. Method Name

`getArticleDetail`

**Role:**
A specialized data recovery method that retrieves the full content and metadata of a specific article by its ID. It is primarily used to hydrate the reading view with the actual Markdown text, which is not present in the list-view metadata.

## 3. Method Responsibility

**Role:**
Defines exactly what the method is accountable for.

*   **Retrieve** the article metadata record from the local registry (`articles.json`).
*   **Hydrate** the article content by reading the associated Markdown file (`contentPath`).
*   **Validate** the input identifier.
*   **Map** technical I/O exceptions (Missing Registry, Missing Content File, Malformed JSON) to Domain Failures.
*   **Combine** metadata and content into a single, fully populated data object.

## 4. Datasource (The Mechanism)

**Focus:** Pure IO interaction, JSON Parsing, File Reading, and Model Hydration.

### 4.1 Full Method Working (Plain English)

**Step 1:** **Check Cache / Initialization Lock:**
   *   Check if the articles list is already cached in memory.
   *   **1a (Concurrent Access):** If an initialization request is already in progress, await the existing `_initFuture` to prevent redundant I/O.
   *   **1b (Not Cached):** Load `database/articles/articles.json`, parse it, skip corrupt records, and cache the result.
**Step 2:** **Target Lookup & Validation:**
   *   Search the list for the first `ArticleModel` where `id` matches `articleId`.
   *   **2a (Not Found):** Throw `NotFoundException`.
   *   **2b (Found but Corrupt):** If the record exists but misses mandatory fields (e.g., `contentPath`), throw `DataParsingException`.
**Step 3:** **Security Validation (Path Traversal):**
   *   Inspect the `contentPath`.
   *   **Validation:** The path **must** start with `database/articles/content/` and **must not** contain the substring `..`.
   *   If validation fails, log a security warning and throw `DataParsingException`.
**Step 4:** **Resource-Constrained Read:**
   *   Access the file at the validated `contentPath`.
   *   **4a (Size Check):** Inspect the byte length before decoding. If the file exceeds **5MB**, throw `DataParsingException` (Oversized Asset).
   *   **4b (Strict Decoding):** Read as UTF-8. If invalid byte sequences are found, throw `DataParsingException` (Encoding Error).
**Step 5:** **Hydrate & Return:**
   *   Create a copy of the model with the `content` field populated.
   *   Return the fully hydrated `ArticleModel`.

### 4.2 Context & Inputs

**Services:**
*   `AssetBundle`: To read both the registry and the content files.

**Data:**
*   Registry Path: `database/articles/articles.json`.
*   Input: `String articleId`.

### 4.3 Edge Cases (Resilience Strategy)

*   **Registry Missing:** `articles.json` not found. -> Throw `DataParsingException`.
*   **Path Traversal (EC-1):** `contentPath` attempts to escape root via `..`. -> Throw `DataParsingException` (Security Rejection).
*   **Concurrent Initialization (EC-2):** Multiple rapid calls for details. -> Handled via `_initFuture` lock.
*   **Oversized Content (EC-3):** File > 5MB. -> Throw `DataParsingException` (Stability Protection).
*   **Encoding Error (EC-4):** Non-UTF8 content. -> Throw `DataParsingException` (Strict Integrity).
*   **Partial Registry Corruption (EC-5):** Mandatory fields missing for target ID. -> Throw `DataParsingException`.
*   **Orphaned Entry (EC-6):** Registry entry exists but physical file is missing. -> Throw `DataParsingException` (Hard Failure).

### 4.4 Architectural Decisions

*   **Initialization Lock:** Ensures expensive JSON parsing happens exactly once, even during concurrent startup requests.
*   **Strict Prefix Enforcement:** Mitigates path traversal by enforcing a hard-coded root and forbidding directory climbing (`..`).
*   **Memory-Bound Constraint:** Protects the application from OOM crashes by capping Markdown file size at 5MB.
*   **Fail-Fast Integrity:** Rejects malformed UTF-8 or corrupt registry entries immediately to ensure a high-quality reading experience.

## 5. Repository (The Policy)

**Focus:** Coordination, Input Validation, and Error Mapping.

### 5.1 Full Method Working (Plain English)

**Step 1:** **Validate Input:**
   *   Check if `articleId` is empty or null.
   *   If invalid, return `Left(ValidationFailure)`.

**Step 2:** **Fetch Data:**
   *   Call the Datasource's `getArticleDetail(articleId)`.

**Step 3:** **Handle Exceptions (Try/Catch):**
   *   Catch `NotFoundException` → Return `Left(NotFoundFailure)`.
   *   Catch `DataParsingException` → Return `Left(DataParsingFailure)`.
   *   Catch generic `Exception` → Return `Left(UnknownFailure)`.

**Step 4:** **Convert & Return:**
   *   Receive the hydrated `ArticleModel`.
   *   Convert it to an `Article` entity using `.toEntity()`.
   *   Return `Right(Article)`.

### 5.2 Context & Inputs

**Services:**
*   `ArticlesRemoteDataSource`: To perform the lookup and hydration.

**Data:**
*   Input: `String articleId`.

## 6. Full Working Flow (Datasource → Repository)

**Step 1:** UI requests `getArticleDetail("a1")`.
**Step 2:** Repository validates ID and calls Datasource.
**Step 3:** Datasource ensures registry is loaded (locking for concurrency).
**Step 4:** Datasource finds "a1", validates path security, and checks file size.
**Step 5:** Datasource reads and strictly decodes the Markdown text.
**Step 6:** Repository catches technical errors and maps them to semantic Failures.
**Step 7:** Repository returns `Right(Article)` to the UI.

## 7. Notes

*   **Security:** Path traversal is mitigated at the mechanism level via prefix enforcement.
*   **Performance:** Double I/O is acceptable for detail views; caching prevents redundant JSON parsing.
*   **Logging:** All `DataParsingException` triggers should be logged via `Talker` with specific context (e.g., "Size limit exceeded") for debugging.

## 8. Clarifying Questions Resolved
*   **Hard Failure Policy:** Confirmed for missing files, encoding errors, and security violations.
*   **Concurrency:** Handled via initialization lock in the Datasource.
*   **Deduplication:** Stateless execution is used for the file read itself, but the registry load is deduplicated.

# Test Specification: getArticleDetail

## 1. Datasource Test Cases (Mechanism-Level)

**Test Case ID: DS-ART-DET-001**
*   **Category:** Datasource
*   **Scenario:** Cold start retrieval (Cache Miss).
*   **Preconditions:** In-memory cache is empty. `articles.json` exists and is valid. Target article "a1" exists with valid content file.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Registry is read/parsed. Returns `ArticleModel` with populated content string. Cache is populated.
*   **Traceability:** Step 1b (Load Registry), Step 5 (Hydrate).

**Test Case ID: DS-ART-DET-002**
*   **Category:** Datasource
*   **Scenario:** Cached retrieval (Cache Hit).
*   **Preconditions:** In-memory cache is already populated with parsed models.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** `articles.json` is **NOT** read again. Returns `ArticleModel` from cache, then hydrates content from file.
*   **Traceability:** Step 1a (Cache Check).

**Test Case ID: DS-ART-DET-003**
*   **Category:** Datasource
*   **Scenario:** Concurrent Initialization (Initialization Lock).
*   **Preconditions:** Cache is empty. Two separate callers invoke `getArticleDetail` simultaneously.
*   **Action:** Execute both calls in parallel.
*   **Expected Outcome:** `articles.json` is parsed exactly **once**. Both callers receive valid `ArticleModel`s.
*   **Traceability:** Step 1a (Init Lock), Edge Case EC-2.

**Test Case ID: DS-ART-DET-004**
*   **Category:** Datasource
*   **Scenario:** Target ID not found.
*   **Preconditions:** Registry is loaded but does not contain ID "unknown".
*   **Action:** Call `getArticleDetail("unknown")`.
*   **Expected Outcome:** Throws `NotFoundException` (Extends `AppException`).
*   **Traceability:** Step 2a.

**Test Case ID: DS-ART-DET-005**
*   **Category:** Datasource
*   **Scenario:** Partial Corruption (Missing Mandatory Field).
*   **Preconditions:** Registry contains ID "a1", but the record is missing `contentPath`.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`).
*   **Traceability:** Step 2b (Target Validation), Edge Case EC-5.

**Test Case ID: DS-ART-DET-006**
*   **Category:** Datasource
*   **Scenario:** Path Traversal Attack (Relative Path).
*   **Preconditions:** Registry contains ID "a1" with `contentPath` set to `database/articles/content/../../secret.txt`.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`). Warning logged. File is **NOT** accessed.
*   **Traceability:** Step 3 (Security Validation), Edge Case EC-1.

**Test Case ID: DS-ART-DET-007**
*   **Category:** Datasource
*   **Scenario:** Path Traversal Attack (Invalid Prefix).
*   **Preconditions:** Registry contains ID "a1" with `contentPath` set to `lib/main.dart` (Valid path, wrong root).
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`). File is **NOT** accessed.
*   **Traceability:** Step 3 (Security Validation), Edge Case EC-1.

**Test Case ID: DS-ART-DET-008**
*   **Category:** Datasource
*   **Scenario:** Oversized Content File.
*   **Preconditions:** Target content file at `contentPath` is physically 5.1 MB.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`). Content is **NOT** decoded to string.
*   **Traceability:** Step 4a (Size Check), Edge Case EC-3.

**Test Case ID: DS-ART-DET-009**
*   **Category:** Datasource
*   **Scenario:** Non-UTF8 Content Encoding.
*   **Preconditions:** Target content file contains invalid binary sequences.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`).
*   **Traceability:** Step 4b (Strict Decoding), Edge Case EC-4.

**Test Case ID: DS-ART-DET-010**
*   **Category:** Datasource
*   **Scenario:** Orphaned Registry Entry (Missing Content File).
*   **Preconditions:** Registry entry valid, but file at `contentPath` does not exist.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Throws `DataParsingException` (Extends `AppException`).
*   **Traceability:** Step 4 (Resource Read), Edge Case EC-6.

**Test Case ID: DS-ART-DET-011**
*   **Category:** Datasource
*   **Scenario:** Empty Content File (Valid Boundary).
*   **Preconditions:** Target content file exists but has 0 bytes.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `ArticleModel` where `content` is an empty string `""`. No exception is thrown.
*   **Traceability:** Section 4.3 (Edge Cases - Empty Content).

---

## 2. Repository Test Cases (Policy-Level)

**Test Case ID: REP-ART-DET-001**
*   **Category:** Repository
*   **Scenario:** Input Validation (Empty ID).
*   **Preconditions:** None.
*   **Action:** Call `getArticleDetail("")`.
*   **Expected Outcome:** Returns `Left(ValidationFailure)`. Datasource is **NOT** called.
*   **Traceability:** Step 1 (Validate Input).

**Test Case ID: REP-ART-DET-002**
*   **Category:** Repository
*   **Scenario:** Successful Success Path.
*   **Preconditions:** Datasource returns valid `ArticleModel` with content.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `Right(Article)`. Entity ID matches input. Entity content matches model content.
*   **Traceability:** Step 2 (Fetch), Step 4 (Convert & Return).

**Test Case ID: REP-ART-DET-003**
*   **Category:** Repository
*   **Scenario:** Error Mapping - Not Found.
*   **Preconditions:** Datasource throws `NotFoundException` (AppException).
*   **Action:** Call `getArticleDetail("unknown")`.
*   **Expected Outcome:** Returns `Left(NotFoundFailure)`. Uses `ErrorMapper` to convert exception.
*   **Traceability:** Step 3 (Handle Exceptions), Error Handling Protocol.

**Test Case ID: REP-ART-DET-004**
*   **Category:** Repository
*   **Scenario:** Error Mapping - Data Parsing (Security/Integrity/Schema).
*   **Preconditions:** Datasource throws `DataParsingException` (AppException).
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `Left(DataParsingFailure)`. Uses `ErrorMapper` to convert exception.
*   **Traceability:** Step 3 (Handle Exceptions), Error Handling Protocol.

**Test Case ID: REP-ART-DET-005**
*   **Category:** Repository
*   **Scenario:** Error Mapping - Unknown Exception.
*   **Preconditions:** Datasource throws generic `Exception`.
*   **Action:** Call `getArticleDetail("a1")`.
*   **Expected Outcome:** Returns `Left(UnknownFailure)`. Uses `ErrorMapper` to catch and map generic exception.
*   **Traceability:** Step 3 (Handle Exceptions), Error Handling Protocol.