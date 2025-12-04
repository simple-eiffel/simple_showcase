note
	description: "[
		Simple Showcase HTTP Server.

		Serves the SSC website using simple_web's HTTP server.
		All pages are generated dynamically from Eiffel classes.

		Usage:
			Run the executable, then browse to configured URL.
			Default: http://localhost:8080

		Configuration:
			Reads from config.json in current directory.
			Use config.production.json for deployment.
	]"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_SERVER

inherit
	SSC_LOGGER

create
	make,
	make_with_config

feature {NONE} -- Initialization

	make
			-- Create and start the server with default config
		do
			make_with_config ("config.json")
		end

	make_with_config (a_config_path: STRING)
			-- Create and start the server with config from `a_config_path`
		require
			path_not_empty: not a_config_path.is_empty
		do
			create config.make (a_config_path)

			if config.verbose_logging then
				print ("%N========================================%N")
				print ("   SSC SERVER - " + config.mode.as_upper + " MODE%N")
				print ("========================================%N%N")
				io.output.flush
			end

			log_info ("server", "=== Simple Showcase Server Starting ===")
			log_info ("server", "Mode: " + config.mode)

			create server.make (config.port)
			log_info ("server", "Server created on port " + config.port.out)

			register_routes
			log_info ("server", "Routes registered")

			print ("%NSimple Showcase Server%N")
			print ("=======================%N")
			print ("Mode: " + config.mode + "%N")
			print ("Open browser to: " + config.base_url + "%N%N")

			server.use_logging
			log_info ("server", "Logging middleware enabled")
			log_info ("server", "Calling server.start (blocking)...")
			server.start
		end

feature -- Server

	server: SIMPLE_WEB_SERVER
			-- HTTP server instance

	config: SSC_CONFIG
			-- Server configuration

feature {NONE} -- Route Registration

	register_routes
			-- Register all page routes
		do
			log_debug ("routes", "Registering page routes...")

			-- Landing page
			server.on_get ("/", agent handle_landing)
			log_debug ("routes", "  GET / -> handle_landing")

			-- Sub-pages
			server.on_get ("/get-started", agent handle_get_started)
			server.on_get ("/portfolio", agent handle_portfolio)
			server.on_get ("/design-by-contract", agent handle_dbc)
			server.on_get ("/workflow", agent handle_workflow)
			server.on_get ("/analysis", agent handle_analysis)
			server.on_get ("/business-case", agent handle_business_case)
			server.on_get ("/why-eiffel", agent handle_why_eiffel)
			server.on_get ("/probable-to-provable", agent handle_probable)
			server.on_get ("/old-way", agent handle_old_way)
			server.on_get ("/ai-changes", agent handle_ai_changes)
			log_debug ("routes", "  Registered 10 sub-page routes")

			-- Redirect .html extensions to clean URLs
			server.on_get ("/index.html", agent handle_redirect_home)
			server.on_get ("/get-started.html", agent handle_redirect_get_started)
			server.on_get ("/portfolio.html", agent handle_redirect_portfolio)
			server.on_get ("/design-by-contract.html", agent handle_redirect_dbc)
			server.on_get ("/workflow.html", agent handle_redirect_workflow)
			server.on_get ("/analysis.html", agent handle_redirect_analysis)
			server.on_get ("/business-case.html", agent handle_redirect_business_case)
			server.on_get ("/why-eiffel.html", agent handle_redirect_why_eiffel)
			server.on_get ("/probable-to-provable.html", agent handle_redirect_probable)
			server.on_get ("/old-way.html", agent handle_redirect_old_way)
			server.on_get ("/ai-changes.html", agent handle_redirect_ai_changes)
			log_debug ("routes", "  Registered .html redirect routes")
		end

feature {NONE} -- Route Handlers

	handle_landing (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the landing page
		local
			l_page: SSC_LANDING_PAGE
			l_html: STRING
		do
			log_enter ("handle_landing")
			log_info ("handler", "Request for landing page from " + req.path.to_string_8)

			log_debug ("handler", "Creating SSC_LANDING_PAGE...")
			create l_page.make
			log_debug ("handler", "SSC_LANDING_PAGE created, calling to_html...")

			l_html := l_page.to_html
			log_info ("handler", "Landing page generated: " + l_html.count.out + " bytes")

			log_debug ("handler", "Sending HTML response...")
			res.send_html (l_html)
			log_exit ("handle_landing")
		end

	handle_get_started (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the get started page
		local
			l_page: SSC_GET_STARTED_PAGE
		do
			log_info ("handler", "Request for /get-started")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_portfolio (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the portfolio page
		local
			l_page: SSC_PORTFOLIO_PAGE
		do
			log_info ("handler", "Request for /portfolio")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_dbc (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the design by contract page
		local
			l_page: SSC_DBC_PAGE
		do
			log_info ("handler", "Request for /design-by-contract")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_workflow (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the workflow page
		local
			l_page: SSC_WORKFLOW_PAGE
		do
			log_info ("handler", "Request for /workflow")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_analysis (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the competitive analysis page
		local
			l_page: SSC_ANALYSIS_PAGE
		do
			log_info ("handler", "Request for /analysis")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_business_case (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the business case page
		local
			l_page: SSC_BUSINESS_CASE_PAGE
		do
			log_info ("handler", "Request for /business-case")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_why_eiffel (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the why eiffel page
		local
			l_page: SSC_WHY_EIFFEL_PAGE
		do
			log_info ("handler", "Request for /why-eiffel")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_probable (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the probable to provable page
		local
			l_page: SSC_PROBABLE_PAGE
		do
			log_info ("handler", "Request for /probable-to-provable")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_old_way (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the old way page
		local
			l_page: SSC_OLD_WAY_PAGE
		do
			log_info ("handler", "Request for /old-way")
			create l_page.make
			res.send_html (l_page.to_html)
		end

	handle_ai_changes (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the AI changes page
		local
			l_page: SSC_AI_CHANGES_PAGE
		do
			log_info ("handler", "Request for /ai-changes")
			create l_page.make
			res.send_html (l_page.to_html)
		end

feature {NONE} -- Redirect Handlers

	handle_redirect_home (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to home
		do
			log_debug ("redirect", "/index.html -> /")
			res.send_redirect ("/")
		end

	handle_redirect_get_started (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to get-started
		do
			log_debug ("redirect", "/get-started.html -> /get-started")
			res.send_redirect ("/get-started")
		end

	handle_redirect_portfolio (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to portfolio
		do
			log_debug ("redirect", "/portfolio.html -> /portfolio")
			res.send_redirect ("/portfolio")
		end

	handle_redirect_dbc (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to design-by-contract
		do
			log_debug ("redirect", "/design-by-contract.html -> /design-by-contract")
			res.send_redirect ("/design-by-contract")
		end

	handle_redirect_workflow (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to workflow
		do
			log_debug ("redirect", "/workflow.html -> /workflow")
			res.send_redirect ("/workflow")
		end

	handle_redirect_analysis (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to analysis
		do
			log_debug ("redirect", "/analysis.html -> /analysis")
			res.send_redirect ("/analysis")
		end

	handle_redirect_business_case (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to business-case
		do
			log_debug ("redirect", "/business-case.html -> /business-case")
			res.send_redirect ("/business-case")
		end

	handle_redirect_why_eiffel (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to why-eiffel
		do
			log_debug ("redirect", "/why-eiffel.html -> /why-eiffel")
			res.send_redirect ("/why-eiffel")
		end

	handle_redirect_probable (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to probable-to-provable
		do
			log_debug ("redirect", "/probable-to-provable.html -> /probable-to-provable")
			res.send_redirect ("/probable-to-provable")
		end

	handle_redirect_old_way (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to old-way
		do
			log_debug ("redirect", "/old-way.html -> /old-way")
			res.send_redirect ("/old-way")
		end

	handle_redirect_ai_changes (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to ai-changes
		do
			log_debug ("redirect", "/ai-changes.html -> /ai-changes")
			res.send_redirect ("/ai-changes")
		end

feature {NONE} -- Helpers

	placeholder_page (a_title, a_message: STRING): STRING
			-- Generate a simple placeholder page
		do
			create Result.make (500)
			Result.append ("<!DOCTYPE html><html><head>")
			Result.append ("<title>" + a_title + " | simple_showcase</title>")
			Result.append ("<script src=%"https://cdn.tailwindcss.com%"></script>")
			Result.append ("</head><body class=%"bg-[#0c0b0b] text-[#fdfcfa] min-h-screen flex items-center justify-center%">")
			Result.append ("<div class=%"text-center%">")
			Result.append ("<h1 class=%"text-4xl font-light mb-4%">" + a_title + "</h1>")
			Result.append ("<p class=%"opacity-60%">" + a_message + "</p>")
			Result.append ("<p class=%"mt-8%"><a href=%"/%" class=%"text-blue-400 hover:underline%">← Back to home</a></p>")
			Result.append ("</div></body></html>")
		end

end
