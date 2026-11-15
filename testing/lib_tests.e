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
			-- Test site generator creation: `make' builds the whole site into docs/ of the working
			-- directory (port-coordination #17: once run in the gate, it rewrote the committed
			-- site). It builds in a scratch folder here, with the one file it reads (docs/sw.js).
		note
			testing: "covers/{SSC_SITE_GENERATOR}.make"
		local
			l_generator: SSC_SITE_GENERATOR
			l_env: detachable EXECUTION_ENVIRONMENT
			l_home: detachable PATH
			l_scratch: PATH
			l_dir: DIRECTORY
			l_in, l_out: PLAIN_TEXT_FILE
			l_index: RAW_FILE
			l_temp: STRING
		do
			create l_env
			l_home := l_env.current_working_path
			if attached l_env.item ("TMPDIR") as al_t then
				l_temp := al_t.to_string_8
			elseif attached l_env.item ("TEMP") as al_t then
				l_temp := al_t.to_string_8
			else
				l_temp := "/tmp"
			end
			l_scratch := (create {PATH}.make_from_string (l_temp)).extended ("simple_showcase_site_test")
			create l_dir.make_with_path (l_scratch.extended ("docs"))
			if not l_dir.exists then
				l_dir.recursive_create_dir
			end
			create l_in.make_open_read ("docs/sw.js")
			l_in.read_stream (l_in.count)
			create l_out.make_with_path (l_scratch.extended ("docs").extended ("sw.js"))
			l_out.create_read_write
			l_out.put_string (l_in.last_string)
			l_out.close
			l_in.close
			l_env.change_working_path (l_scratch)
			create l_generator.make
			create l_index.make_with_name ("docs/index.html")
			assert ("landing page written", l_index.exists and then l_index.count > 0)
			assert_attached ("generator created", l_generator)
			l_env.change_working_path (l_home)
		rescue
				-- back to the repository folder before the failure goes on
			if attached l_env as al_env and attached l_home as al_home then
				al_env.change_working_path (al_home)
			end
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
