# S01: PROJECT INVENTORY
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## Project Structure

```
simple_showcase/
├── src/
│   ├── core/
│   │   ├── ssc_server.e           # HTTP server
│   │   ├── ssc_site_generator.e   # Static site generator
│   │   ├── ssc_database.e         # SQLite persistence
│   │   ├── ssc_config.e           # Configuration
│   │   ├── ssc_page.e             # Base page class
│   │   ├── ssc_sub_page.e         # Sub-page variant
│   │   ├── ssc_shared.e           # Shared constants
│   │   ├── ssc_logger.e           # Logging mixin
│   │   ├── ssc_glossary.e         # Term definitions
│   │   └── ssc_analytics_middleware.e
│   ├── pages/
│   │   ├── ssc_landing_page.e
│   │   ├── ssc_get_started_page.e
│   │   ├── ssc_portfolio_page.e
│   │   ├── ssc_dbc_page.e
│   │   ├── ssc_workflow_page.e
│   │   ├── ssc_analysis_page.e
│   │   ├── ssc_business_case_page.e
│   │   ├── ssc_why_eiffel_page.e
│   │   ├── ssc_probable_page.e
│   │   ├── ssc_old_way_page.e
│   │   ├── ssc_ai_changes_page.e
│   │   ├── ssc_contact_page.e
│   │   └── ssc_full_report_page.e
│   └── components/
│       ├── ssc_section.e
│       ├── ssc_hero_section.e
│       └── ... (10 section classes)
├── testing/
├── docs/                          # Generated static site
├── research/
├── specs/
└── simple_showcase.ecf
```

## Dependencies

- simple_web, simple_sql, simple_json, simple_datetime
- simple_logger, simple_htmx, simple_process
