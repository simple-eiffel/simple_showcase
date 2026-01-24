# S07: SPECIFICATION SUMMARY
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## One-Line Description

Marketing website for the Simple Eiffel ecosystem with dynamic server and static site generation capabilities.

## Key Specifications

| Aspect | Specification |
|--------|---------------|
| **Type** | Web Application |
| **Modes** | Dynamic server, Static generator |
| **Language** | Eiffel |
| **Frontend** | Tailwind CSS, Alpine.js |
| **Database** | SQLite |
| **Pages** | 13 content pages |

## Pages

| Page | Purpose |
|------|---------|
| Landing | Hero, value proposition |
| Get Started | Onboarding guide |
| Portfolio | Library showcase |
| Design by Contract | DBC education |
| Workflow | Development process |
| Analysis | Competitive comparison |
| Business Case | ROI justification |
| Why Eiffel | Language benefits |
| Probable to Provable | Formal methods |
| Old Way | Problem statement |
| AI Changes | AI integration |
| Contact | Form submission |
| Full Report | Detailed analysis |

## Data Flow

1. **Request**: Browser -> Server -> Route Handler -> Page Class -> HTML
2. **Contact**: Form -> JSON Parse -> Validate -> Sanitize -> DB + Email
3. **Static**: Generator -> Page.to_html -> File Write -> /docs

## Critical Invariants

1. All pages inherit from SSC_PAGE with title/description
2. Contact form inputs are always sanitized
3. Rate limiting tracked by IP address
4. Database schema auto-created on startup
