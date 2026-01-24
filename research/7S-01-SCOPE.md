# 7S-01: SCOPE
**Library**: simple_showcase
**Status**: BACKWASH (retroactive documentation)
**Date**: 2026-01-23

## What Problem Does This Solve?

simple_showcase is a marketing website for the Simple Eiffel ecosystem:
- Demonstrates Eiffel and Design by Contract capabilities
- Provides educational content about the "new way" of development
- Serves as a portfolio/showcase for the library ecosystem
- Handles contact form submissions with database storage

## Target Users

1. **Potential Adopters** - Developers evaluating Eiffel
2. **Business Decision Makers** - Reading business case content
3. **Curious Visitors** - Learning about DBC and formal methods

## Domain

Static site generation and HTTP web serving for marketing content.

## In-Scope

- Static site generation for GitHub Pages
- Dynamic HTTP server with simple_web
- Multiple content pages (landing, portfolio, DBC, workflow, etc.)
- Contact form with email notification and SQLite storage
- Analytics tracking
- Rate limiting
- Session management

## Out-of-Scope

- User authentication for public pages
- E-commerce functionality
- Content management system
- Multi-language support
