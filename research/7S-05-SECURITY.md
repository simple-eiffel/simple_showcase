# 7S-05: SECURITY
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## Security Considerations

### Threat Model

1. **Contact Form Injection**: Email header injection, SQL injection
2. **Rate Limiting Bypass**: Form submission abuse
3. **XSS Attacks**: Malicious content in submissions
4. **Credential Exposure**: SMTP password in config

### Mitigations Implemented

#### Input Sanitization
```eiffel
sanitize_for_email (a_text: STRING): STRING
    -- Removes: newlines, quotes, backticks, $, \, |, &, ;, <, >
    ensure
        no_newlines: not Result.has ('%N')
        no_shell_chars: not Result.has ('|')
```

#### Email Validation
```eiffel
is_valid_email (a_email: STRING): BOOLEAN
    -- Checks: length 5-254, has @, has . after @
    ensure
        valid_implies_has_at: Result implies a_email.has ('@')
```

#### Rate Limiting
- 5 submissions per hour per IP
- Stored in memory hash table
- 429 response on limit exceeded

#### Control Character Removal
```eiffel
remove_control_chars (a_string: STRING): STRING
    -- Removes 0x00-0x1F except tab/newline/CR
    ensure
        no_dangerous_control_chars: not has_dangerous_control_chars (Result)
```

### Remaining Risks

1. **SMTP Password**: Stored in config.json (should use env var)
2. **IP Spoofing**: X-Forwarded-For can be manipulated
3. **Static Files**: No CSP headers on GitHub Pages

### Recommendations

1. Move SMTP credentials to environment variables
2. Implement CAPTCHA for contact form
3. Add Content Security Policy headers
4. Consider WAF for production deployment
