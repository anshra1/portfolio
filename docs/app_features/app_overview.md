# App Overview

## App Purpose

This application is a **developer-focused portfolio platform** designed to showcase projects, technical articles, and professional expertise through a clean, structured, and scalable architecture.

The app is intentionally built using **production-grade practices** to demonstrate not only what is displayed, but *how* the system is designed and executed.

---

## What This App Is

* A read-only portfolio application
* A demonstration of feature-first system design
* A reference implementation of Clean Architecture with TDD
* A controlled environment for safe AI-assisted development

---

## What This App Is Not

* A CMS or blogging platform
* A social or interactive application
* A backend-driven production service
* A UI experiment or animation showcase

---

## App-Level Architectural Principles

These rules apply to the entire application and are never redefined at the feature level.

* Clean Architecture with strict dependency direction
* Feature-first design (features own behavior, not screens)
* Explicit separation of app, feature, and method-level decisions
* Result / Failure–based error handling
* Read-only domain model
* No background processes
* No offline-first behavior

---

## Feature Map

The application is composed of the following **independent features**. Each feature owns its entities, behavior, and architectural decisions within its scope.

---

### 1. Home Feature

**Purpose**
Acts as the central landing and orchestration feature.

**Responsibilities**

* Present featured projects and articles
* Display profile and expertise information
* Route users to deeper feature areas

**Non-Responsibilities**

* Business logic
* Data transformation

---

### 2. Projects Feature

**Purpose**
Showcases the full body of development work and technical depth.

**Responsibilities**

* Provide lists of featured and archived projects
* Provide detailed technical views of individual projects
* Enable external actions (source code, downloads, app stores)

**Non-Responsibilities**

* Project creation or management
* Analytics

---

### 3. Articles Feature

**Purpose**
Provides long-form written content focused on learning and technical insights.

**Responsibilities**

* Provide searchable and filterable article lists
* Provide detailed reader views for individual articles

**Non-Responsibilities**

* Content creation or editing
* User engagement tracking

---

### 4. System / Platform Feature

**Purpose**
Abstracts platform-level capabilities behind a stable interface.

**Responsibilities**

* Open external URLs
* Trigger email intents
* Trigger file downloads
* Check network connectivity

**Non-Responsibilities**

* Business decision-making
* UI presentation

---

## Feature Interaction Rules

* Features do not depend on each other’s internal logic
* Navigation passes only primitive identifiers (IDs)
* Shared UI components live outside feature logic
* Platform capabilities are accessed only through the System feature

---

## Development Model

* All features are designed before coding
* Feature and method behavior is defined in Markdown
* Code and tests must follow written contracts
* AI is used only as a constrained implementer

---

## Source of Truth Rule

If code, tests, and documentation ever disagree, **documentation wins**.

All changes start by updating the relevant MD files first.
