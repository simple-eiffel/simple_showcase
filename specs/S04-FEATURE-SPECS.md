# S04: FEATURE SPECIFICATIONS
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## SSC_SERVER Features

### Route Handling
| Feature | Route | Description |
|---------|-------|-------------|
| handle_landing | GET / | Serve landing page |
| handle_get_started | GET /get-started | Onboarding page |
| handle_portfolio | GET /portfolio | Library showcase |
| handle_contact | GET /contact | Contact form |
| handle_contact_submit | POST /api/contact | Form submission |

### Security Features
| Feature | Signature | Description |
|---------|-----------|-------------|
| sanitize_for_email | (STRING): STRING | Remove injection chars |
| sanitize_email_address | (STRING): STRING | Whitelist email chars |
| remove_control_chars | (STRING): STRING | Strip dangerous bytes |
| is_valid_email | (STRING): BOOLEAN | Format validation |
| is_rate_limited | (STRING): BOOLEAN | Check IP rate limit |

### Middleware
| Feature | Description |
|---------|-------------|
| SSC_ANALYTICS_MIDDLEWARE | Log all requests |
| use_logging | Enable request logging |

## SSC_DATABASE Features

### Analytics
| Feature | Signature | Description |
|---------|-----------|-------------|
| log_request | (path, method, ip, ...): | Record request |
| get_page_view_counts | : ARRAYED_LIST | Views by path |
| get_analytics_summary | : TUPLE | Aggregate stats |

### Contacts
| Feature | Signature | Description |
|---------|-----------|-------------|
| save_contact | (...): INTEGER_64 | Store submission |
| get_contacts | (INTEGER): ARRAYED_LIST | Retrieve contacts |
| mark_contact_read | (INTEGER_64) | Mark as read |
| get_unread_contact_count | : INTEGER | Unread count |

### Sessions
| Feature | Signature | Description |
|---------|-----------|-------------|
| create_session | (token, hours): BOOLEAN | Create session |
| validate_session | (token): BOOLEAN | Check validity |
| delete_session | (token) | Logout |
