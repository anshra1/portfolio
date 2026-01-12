# Tech Stack

## 0. Purpose

This document defines the **complete, approved technology stack** for this project.

It answers one question only:

> **What technologies are allowed to be used to build and operate this system?**

Anything not listed here is **not allowed** unless explicitly approved.

---

## 1. Product & Scope

* **Application Type:** Static website
* **Framework Output:** Flutter Web (static build)
* **Target Platform:** Web browsers only
* **Project Scale:** Small / personal
* **Performance Sensitivity:** High (low-end devices matter)

---

## 2. Language & SDK

* **Framework:** Flutter (Web)
* **Flutter Channel:** Stable only
* **Null Safety:** Mandatory
* **Flutter SDK:** Latest stable (version pinned once selected)
* **Dart SDK:** Compatible with pinned Flutter version

---

## 3. UI & Design System

* **UI Framework:** Flutter Material
* **Design System:** Material Design
* **Local UI Kit:** `core_ui_kit` (Internal shared components)
* **Asset Management:** `flutter_gen` (Type-safe asset generation)
* **Styling Rules:**
  * Centralized theme only
  * No inline colors or text styles
* **Animations:** Moderate, performance-aware only

---

## 4. State Management & Equality

* **Primary State Management:** `flutter_bloc`
* **Equality & Value Comparison:** `equatable`
* **Multiple State Management Solutions:** Not allowed

---

## 5. Dependency Injection

* **DI Tool:** `get_it` & `flutter_getit`
* **Service Locator Usage in UI:** Allowed (via `get_it` or `flutter_getit`)

---

## 6. Navigation

* **Routing Solution:** `go_router`
* **Deep Linking:** Not required

---

## 7. Networking & APIs

* **Networking:** Not used initially
* **API Style:** Not applicable
* **HTTP Client:** Not defined
* **Serialization:** `freezed` & `json_serializable` (for data models)

---

## 8. Functional Programming

* **Functional Utilities:** `fpdart` (Primarily for `Either` types in error handling)

---

## 9. Storage & Caching

* **Local Persistence:** None
* **Caching Strategy:** In-memory only
* **Secure Storage:** Not required

---

## 10. Background & Async

* **Background Tasks:** Not required
* **Async Strategy:** Strict per use case

---

## 11. Analytics, Errors & Logging

* **Core Services:** `firebase_core`
* **Analytics:** `firebase_analytics`
* **Crash Reporting:** `firebase_crashlytics`
* **Logging:** Talker Ecosystem
  * `talker` (Core logging)
  * `talker_flutter` (UI/Display integration)
  * `talker_bloc_logger` (BLoC state transition logging)

---

## 12. Testing Stack

* **Unit Tests:** Mandatory
* **Mocking Library:** `mocktail`
* **Fake Data Generation:** `faker`
* **UI Tests:**
  * Widget tests
  * Golden tests
* **Integration Tests:** Required

---

## 13. Code Quality

* **Linting:**
  * `very_good_analysis` (Strict standard)
  * `flutter_lints` (Basic Flutter standards)
* **Formatting:** `dart format` (mandatory)

---

## 14. Build, Hosting & Environments

* **Environment Strategy:** Internal configuration via `AppEnvironment` and `AppConfig`.
* **Current Active Environment:** `dev` only.
* **Build Output:** Static web assets.
* **Hosting:** Static hosting (e.g., Firebase Hosting).
* **CI/CD:** Not defined.

---

## 15. AI Usage Policy

* **Stack Philosophy:** Modern but stable
* **AI Behavior Rules:**
  * Must ask before adding any new tools, libraries, services, or platforms
  * Must not assume missing technologies
  * Must respect performance constraints

---

## 16. Constraints & Non-Goals

* No mobile or desktop targets
* No server-side rendering
* No backend services
* No local persistent storage
* No experimental or beta libraries


---

**This file defines WHAT is allowed.**
**Architecture, layering, and behavior are governed by the System Pattern file.**