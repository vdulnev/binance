# [Project Name] — Technical Specification

> **Status:** Draft | Review | Approved | Implementing | Complete
> **Author:** [Name]
> **Created:** [Date]
> **Last Updated:** [Date]
> **Version:** 0.1.0

---

## 1. Overview

### 1.1 Problem Statement

<!-- What problem are we solving? Why does it matter? Who is affected? -->

### 1.2 Goals

<!-- What does success look like? Be specific and measurable. -->

- **G1:** ...
- **G2:** ...

### 1.3 Non-Goals

<!-- What are we explicitly NOT doing? This prevents scope creep. -->

- ...

---

## 2. User Stories

<!-- Describe behaviors from the user's perspective. -->

| ID   | As a...       | I want to...              | So that...                  | Priority   |
|------|---------------|---------------------------|-----------------------------|------------|
| US-1 | [role]        | [action]                  | [benefit]                   | Must-have  |
| US-2 | [role]        | [action]                  | [benefit]                   | Should-have|
| US-3 | [role]        | [action]                  | [benefit]                   | Nice-to-have|

---

## 3. Functional Requirements

### 3.1 [Feature Area 1]

<!-- Describe what the system must do. Use clear, testable language. -->

- **FR-1.1:** The system shall ...
- **FR-1.2:** The system shall ...

### 3.2 [Feature Area 2]

- **FR-2.1:** The system shall ...

---

## 4. Non-Functional Requirements

| ID    | Category       | Requirement                                      | Target            |
|-------|----------------|--------------------------------------------------|--------------------|
| NFR-1 | Performance    | Page load time                                   | < 200ms p95        |
| NFR-2 | Availability   | Uptime                                           | 99.9%              |
| NFR-3 | Security       | Authentication method                            | OAuth 2.0 / JWT    |
| NFR-4 | Accessibility  | WCAG compliance                                  | Level AA           |
| NFR-5 | Compatibility  | Supported platforms / browsers                   | [list]             |
| NFR-6 | Scalability    | Expected concurrent users / data volume          | [target]           |

---

## 5. Architecture & Technical Design

### 5.1 System Overview

<!-- High-level architecture: services, layers, external dependencies. -->
<!-- Include a diagram reference if available (e.g., Mermaid, draw.io). -->

```
[Client] → [API Gateway] → [Service A] → [Database]
                         → [Service B] → [External API]
```

### 5.2 Tech Stack

| Layer          | Technology         | Rationale                          |
|----------------|--------------------|------------------------------------|
| Frontend       | [e.g., Flutter]    | [why]                              |
| Backend        | [e.g., Node.js]    | [why]                              |
| Database       | [e.g., PostgreSQL] | [why]                              |
| Infrastructure | [e.g., Docker/K8s] | [why]                              |

### 5.3 Key Design Decisions

<!-- Document important architectural choices and their trade-offs. -->

| Decision                    | Choice           | Alternatives Considered | Rationale          |
|-----------------------------|------------------|-------------------------|--------------------|
| State management            | [choice]         | [alternatives]          | [why]              |
| API style                   | [REST/GraphQL]   | [alternatives]          | [why]              |

---

## 6. Data Model

### 6.1 Entities

<!-- Define core entities, their fields, types, and constraints. -->

#### [Entity Name]

| Field        | Type       | Constraints              | Description               |
|--------------|------------|--------------------------|---------------------------|
| id           | UUID       | PK, auto-generated       | Unique identifier         |
| name         | string     | required, max 255 chars  | Display name              |
| created_at   | datetime   | auto-set                 | Creation timestamp        |

### 6.2 Relationships

<!-- Describe how entities relate to each other. -->

- [Entity A] has many [Entity B]
- [Entity B] belongs to [Entity A]

---

## 7. API / Interface Contract

### 7.1 Endpoints

<!-- Define inputs, outputs, and error responses for each endpoint or function. -->

#### `POST /api/[resource]`

**Description:** Creates a new [resource].

**Request:**
```json
{
  "name": "string (required)",
  "description": "string (optional)"
}
```

**Response (201):**
```json
{
  "id": "uuid",
  "name": "string",
  "created_at": "ISO 8601"
}
```

**Errors:**

| Status | Code              | When                        |
|--------|-------------------|-----------------------------|
| 400    | VALIDATION_ERROR  | Missing or invalid fields   |
| 409    | ALREADY_EXISTS    | Duplicate name              |
| 500    | INTERNAL_ERROR    | Unexpected server failure   |

---

## 8. Edge Cases & Error Handling

<!-- List known edge cases and how the system should handle them. -->

| ID   | Scenario                              | Expected Behavior                        |
|------|---------------------------------------|------------------------------------------|
| EC-1 | User submits empty form               | Show validation errors, block submission |
| EC-2 | Network timeout on external API call  | Retry 2x, then return graceful fallback  |
| EC-3 | Concurrent edits to same resource     | Last-write-wins / optimistic locking     |
| EC-4 | Input exceeds size limits             | Reject with 413, show user message       |

---

## 9. Acceptance Criteria

<!-- These are the concrete checks that determine "done". Map back to user stories. -->

| ID   | Linked To | Criterion                                                    | Verified |
|------|-----------|--------------------------------------------------------------|----------|
| AC-1 | US-1      | User can create a [resource] and see it in the list          | [ ]      |
| AC-2 | US-1      | Creating a [resource] with invalid data shows error messages | [ ]      |
| AC-3 | US-2      | User can delete a [resource]; it disappears immediately      | [ ]      |

---

## 10. Implementation Plan

<!-- Ordered list of tasks, each small enough to implement and test independently. -->

| Phase | Task                                  | Depends On | Est. Effort | Status      |
|-------|---------------------------------------|------------|-------------|-------------|
| 1     | Set up project scaffold + CI          | —          | S           | Not started |
| 2     | Implement data model + migrations     | Phase 1    | M           | Not started |
| 3     | Build [Feature Area 1] API            | Phase 2    | M           | Not started |
| 4     | Build [Feature Area 1] UI             | Phase 3    | L           | Not started |
| 5     | Build [Feature Area 2] API + UI       | Phase 2    | L           | Not started |
| 6     | Integration testing + edge cases      | Phase 4, 5 | M           | Not started |
| 7     | Performance tuning + NFR validation   | Phase 6    | S           | Not started |

> **Effort scale:** S = hours, M = 1–2 days, L = 3–5 days, XL = 1+ week

---

## 11. Testing Strategy

| Type              | Scope                          | Tool / Approach          |
|-------------------|--------------------------------|--------------------------|
| Unit tests        | Business logic, utilities      | [e.g., Jest, pytest]     |
| Integration tests | API endpoints, DB queries      | [e.g., Supertest]        |
| E2E tests         | Critical user flows            | [e.g., Playwright]       |
| Manual QA         | Edge cases, visual review      | Checklist-based          |

---

## 12. Open Questions

<!-- Track unresolved decisions. Resolve before moving status to "Approved". -->

| #  | Question                                             | Owner   | Status   | Resolution |
|----|------------------------------------------------------|---------|----------|------------|
| 1  | Should we support [feature X] in v1?                 | [name]  | Open     |            |
| 2  | Which auth provider to use?                          | [name]  | Resolved | Firebase   |

---

## 13. Changelog

| Version | Date       | Author  | Changes                  |
|---------|------------|---------|--------------------------|
| 0.1.0   | [date]     | [name]  | Initial draft            |

---

<!-- 
=============================================================
  CLAUDE USAGE GUIDE
=============================================================

How to use this spec with Claude:

1. DRAFTING — Paste this template and say:
   "Help me fill out this spec for [project idea]. Interview me first."

2. DECOMPOSITION — After the spec is filled, say:
   "Break this spec into implementation tasks for Phase [N]."

3. IMPLEMENTATION — For each task, say:
   "Here's the spec [paste section]. Implement task [N]. Write tests."

4. REVIEW — After implementation, say:
   "Here's the spec and the code. Does it satisfy all acceptance criteria? List gaps."

5. CHANGE MANAGEMENT — When requirements change:
   "I've updated section [X] of the spec. What code needs to change?"

Tips:
- Keep this file in your repo (e.g., docs/SPEC.md) for Claude Code access.
- Reference it in CLAUDE.md: "Always check docs/SPEC.md before implementing."
- Update the changelog when the spec evolves.
=============================================================
-->
