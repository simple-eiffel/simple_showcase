# S03: CONTRACTS
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## Design by Contract Summary

### SSC_PAGE Contracts

```eiffel
title: STRING
    deferred
    ensure
        not_empty: Result /= Void and then not Result.is_empty

description: STRING
    deferred
    ensure
        not_empty: Result /= Void and then not Result.is_empty

to_html: STRING
    ensure
        not_empty: not Result.is_empty
        starts_with_doctype: Result.starts_with ("<!DOCTYPE html>")

body_content: STRING
    deferred
    ensure
        not_empty: not Result.is_empty
```

### SSC_SERVER Validation Contracts

```eiffel
extract_and_sanitize_field (a_obj: SIMPLE_JSON_OBJECT; a_field: STRING; a_max_length: INTEGER): STRING
    require
        obj_attached: a_obj /= Void
        field_not_empty: not a_field.is_empty
        max_positive: a_max_length > 0
    ensure
        result_attached: Result /= Void
        within_limit: Result.count <= a_max_length

remove_control_chars (a_string: STRING): STRING
    ensure
        result_attached: Result /= Void
        no_dangerous_control_chars: not has_dangerous_control_chars (Result)
        length_not_increased: Result.count <= a_string.count

is_valid_email (a_email: STRING): BOOLEAN
    ensure
        valid_implies_has_at: Result implies a_email.has ('@')
        valid_implies_length_ok: Result implies (a_email.count >= 5 and a_email.count <= 254)
```

### SSC_DATABASE Contracts

```eiffel
make (a_db_path: STRING)
    require
        path_not_empty: not a_db_path.is_empty
    ensure
        db_open: db.is_open

save_contact (a_name, a_email, a_subject, a_message, a_ip: STRING): INTEGER_64
    require
        db_open: db.is_open
        name_not_empty: not a_name.is_empty
        email_not_empty: not a_email.is_empty
        message_not_empty: not a_message.is_empty

invariant
    db_attached: db /= Void
    db_path_not_empty: not db_path.is_empty
```
