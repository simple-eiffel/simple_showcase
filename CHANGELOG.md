# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Security
- 2026-11-25: `deploy/curl.exe` is curl 8.23.0 (curl.se build 8.23.0_10; 8.17.0 before), LibreSSL 4.4.1 and libssh2 1.11.1 built in, the same build simple_pdf ships as its libcurl.dll. `deploy/curl-ca-bundle.crt` is curl.se's Mozilla extract of 2026-11-05 (2025-11-04 before; SHA-256 427c064216761a1e72a8b30f0d954d08cb6e4435a82091fb865afd20c8497285, as published). Removed `deploy/libcurl-x64.dll`: curl.exe has libcurl built in and simple_showcase.exe imports only Windows DLLs. curl.exe makes a verified HTTPS request with only System32 on PATH.

### Fixed (build warnings)
- The test build now compiles with zero warnings, so `ec.sh test` exits 0
  instead of 2. The 9 VWMA(1) warnings in SSC_DATABASE and
  SSC_ANALYTICS_MIDDLEWARE came from untyped `<<...>>` SQL argument arrays
  passed as `ARRAY [detachable ANY]`; each one is now typed explicitly.

### Fixed (process output)
- The email debug log UTF-8 encodes curl's output instead of `to_string_8`,
  which failed on characters above U+00FF since simple_process 1.1.0.


### Changed
- Testing config updates, AutoTest fixes, .gitignore cleanup
- Add SCOOP concurrency capability
- Migrate to simple_testing library
- Fix SQLite cross-thread access bug in analytics middleware
- Add full-report page and regenerate static site
- Add Competitive Analysis page with accurate Christmas Sprint data
- Add comprehensive tests for Christmas Sprint content
- Update showcase for Christmas Sprint completion (v2.0)
- Refactor to use APP_API facade for library access
- Add *.rc to gitignore (build artifacts)

## [1.0.0] - 2025-12-08

### Added
- Initial release
- Core functionality implemented
- Test suite with comprehensive coverage
- Documentation and examples

[Unreleased]: https://github.com/simple-eiffel/simple_showcase/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/simple-eiffel/simple_showcase/releases/tag/v1.0.0
