# S02: CLASS CATALOG
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## Class Hierarchy

```
SSC_LOGGER (mixin)
├── SSC_SERVER
├── SSC_DATABASE
└── SSC_SITE_GENERATOR

SSC_SHARED (constants mixin)
└── SSC_PAGE (deferred)
    └── SSC_SUB_PAGE
        └── [All page classes]

ANY
├── SSC_CONFIG
├── SSC_GLOSSARY
├── SSC_SECTION
└── SSC_ANALYTICS_MIDDLEWARE
```

## Core Classes

### SSC_SERVER
**Purpose**: HTTP server entry point
**Responsibilities**: Route registration, request handling, middleware

### SSC_SITE_GENERATOR
**Purpose**: Generate static HTML files
**Responsibilities**: Create /docs folder, render all pages

### SSC_DATABASE
**Purpose**: SQLite persistence layer
**Responsibilities**: Analytics, contacts, sessions CRUD

### SSC_PAGE
**Purpose**: Abstract base for all pages
**Responsibilities**: HTML structure, head/body generation

## Page Classes (13)

| Class | Route | Content |
|-------|-------|---------|
| SSC_LANDING_PAGE | / | Hero, sections |
| SSC_GET_STARTED_PAGE | /get-started | Onboarding |
| SSC_PORTFOLIO_PAGE | /portfolio | Library showcase |
| SSC_DBC_PAGE | /design-by-contract | DBC education |
| SSC_WORKFLOW_PAGE | /workflow | Development process |
| SSC_ANALYSIS_PAGE | /analysis | Competitive analysis |
| SSC_BUSINESS_CASE_PAGE | /business-case | ROI content |
| SSC_WHY_EIFFEL_PAGE | /why-eiffel | Language benefits |
| SSC_PROBABLE_PAGE | /probable-to-provable | Formal methods |
| SSC_OLD_WAY_PAGE | /old-way | Problem description |
| SSC_AI_CHANGES_PAGE | /ai-changes | AI integration |
| SSC_CONTACT_PAGE | /contact | Contact form |
| SSC_FULL_REPORT_PAGE | /full-report | Detailed report |
