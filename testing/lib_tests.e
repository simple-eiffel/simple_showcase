note
	description: "Tests for SIMPLE_SHOWCASE"
	author: "Larry Rix"
	date: "$Date$"
	revision: "$Revision$"
	testing: "covers"

class
	LIB_TESTS

inherit
	TEST_SET_BASE

feature -- Test: Config

	test_config_make_default
			-- Test config creation with defaults.
		note
			testing: "covers/{SSC_CONFIG}.make_default"
		local
			config: SSC_CONFIG
		do
			create config.make_default
			assert_attached ("config created", config)
			assert_true ("has port", config.port > 0)
		end

feature -- Test: Site Generator

	test_site_generator_make
			-- Test site generator creation.
		note
			testing: "covers/{SSC_SITE_GENERATOR}.make"
		local
			l_generator: SSC_SITE_GENERATOR
		do
			create l_generator.make
			assert_attached ("generator created", l_generator)
		end

feature -- Test: Page

	test_landing_page_make
			-- Test landing page creation.
		note
			testing: "covers/{SSC_LANDING_PAGE}.make"
		local
			page: SSC_LANDING_PAGE
		do
			create page.make
			assert_attached ("page created", page)
		end

	test_landing_page_to_html
			-- Test landing page HTML generation.
		note
			testing: "covers/{SSC_LANDING_PAGE}.to_html"
		local
			page: SSC_LANDING_PAGE
			html: STRING
		do
			create page.make
			html := page.to_html
			assert_false ("not empty", html.is_empty)
			assert_string_contains ("has doctype", html, "<!DOCTYPE html>")
		end

feature -- Test: Database

	test_database_make
			-- Test database creation.
		note
			testing: "covers/{SSC_DATABASE}.make"
		local
			db: SSC_DATABASE
		do
			create db.make (":memory:")
			assert_attached ("db created", db)
		end

end
