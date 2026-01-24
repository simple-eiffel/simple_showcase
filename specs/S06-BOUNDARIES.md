# S06: BOUNDARIES
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## System Boundaries

```
┌────────────────────────────────────────────────────────────┐
│                     simple_showcase                         │
│  ┌──────────────────────────────────────────────────────┐ │
│  │                    SSC_SERVER                         │ │
│  │  (routes, handlers, middleware, rate limiting)       │ │
│  └──────────────────────────────────────────────────────┘ │
│         │                    │                    │        │
│         ▼                    ▼                    ▼        │
│  ┌────────────┐      ┌────────────┐      ┌────────────┐  │
│  │  SSC_PAGE  │      │SSC_DATABASE│      │ SSC_CONFIG │  │
│  │  classes   │      │  (SQLite)  │      │  (JSON)    │  │
│  └────────────┘      └────────────┘      └────────────┘  │
│         │                    │                             │
│         ▼                    ▼                             │
│  ┌────────────┐      ┌────────────┐                       │
│  │ SSC_SECTION│      │  SMTP      │                       │
│  │ components │      │ (curl)     │                       │
│  └────────────┘      └────────────┘                       │
└────────────────────────────────────────────────────────────┘
         │                    │                    │
         ▼                    ▼                    ▼
   ┌──────────┐        ┌──────────┐        ┌──────────┐
   │  Browser │        │ SQLite DB│        │ Email    │
   │ (client) │        │ (file)   │        │ Server   │
   └──────────┘        └──────────┘        └──────────┘
```

## Interface Boundaries

### HTTP Interface
- **Port**: Configurable (default 8080)
- **Routes**: Clean URLs, no extensions
- **Content**: HTML, JSON (API)

### Database Interface
- **Engine**: SQLite
- **Tables**: analytics, contacts, sessions
- **Indexes**: Optimized for common queries

### Email Interface
- **Method**: SMTP via curl
- **Auth**: Username/password
- **Protocol**: STARTTLS (port 587)

### Static Site Interface
- **Output**: /docs folder
- **Format**: HTML files with index.html pattern
- **Assets**: Served from same folder
