# S05: CONSTRAINTS
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## Technical Constraints

### Server Mode
- Port configurable via config.json
- Blocking server (main thread)
- Worker pool for request handling

### Static Mode
- Output to /docs folder
- GitHub Pages compatible
- Service worker for caching

### Database
- SQLite for persistence
- Single database file
- Auto-schema creation

## Design Constraints

### Page Architecture
- All pages inherit from SSC_PAGE
- Content generated as Eiffel strings
- No template files - code IS the template

### Frontend
- Tailwind CSS via CDN
- Alpine.js via CDN
- No build step required

### Content Management
- Content embedded in Eiffel code
- Changes require recompilation
- No external CMS integration

## Operational Constraints

### Rate Limiting
- 5 submissions per hour per IP
- In-memory tracking (lost on restart)
- No distributed rate limiting

### Email
- SMTP credentials in config file
- Synchronous sending
- No retry on failure

### Analytics
- Per-request database writes
- No real-time aggregation
- Manual query for reports
