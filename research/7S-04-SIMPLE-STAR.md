# 7S-04: SIMPLE-STAR ECOSYSTEM
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## Ecosystem Dependencies

### Uses (Dependencies)
- **simple_web** - HTTP server (SIMPLE_WEB_SERVER)
- **simple_sql** - SQLite database (SIMPLE_SQL_DATABASE)
- **simple_datetime** - Date/time formatting
- **simple_json** - JSON parsing for contact form
- **simple_logger** - Structured logging
- **simple_htmx** - HTML component patterns

### Used By (Dependents)
- None (standalone application)

## Integration Points

### simple_web Usage
```eiffel
create server.make (config.port)
server.on_get ("/", agent handle_landing)
server.on_post ("/api/contact", agent handle_contact_submit)
server.use_middleware (create {SSC_ANALYTICS_MIDDLEWARE}.make (db_path))
server.start
```

### simple_sql Usage
```eiffel
db.execute_with_args (
    "INSERT INTO contacts (name, email, subject, message, ip_address) VALUES (?, ?, ?, ?, ?)",
    <<a_name, a_email, a_subject, a_message, a_ip>>
)
```

### simple_json Usage
```eiffel
l_body := l_json.decode_payload (req.body)
if attached l_body.as_object as l_obj then
    l_name := l_obj.item ("name").as_string_32
end
```

## Ecosystem Role

simple_showcase is an **application** that demonstrates the simple_* ecosystem - it's both a product AND a demonstration of the libraries it uses.
