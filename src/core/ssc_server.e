note
	description: "[
		Simple Showcase HTTP Server.

		Serves the SSC website using simple_web's HTTP server.
		All pages are generated dynamically from Eiffel classes.

		Usage:
			Run the executable, then browse to http://localhost:8080
	]"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_SERVER

inherit
	SSC_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create and start the server
		do
			print ("%N========================================%N")
			print ("   SSC LOGGING ENABLED - VERBOSE MODE%N")
			print ("========================================%N%N")
			io.output.flush
			log_info ("server", "=== Simple Showcase Server Starting ===")
			create server.make (8080)
			log_info ("server", "Server created on port 8080")
			register_routes
			log_info ("server", "Routes registered")
			print ("%NSimple Showcase Server%N")
			print ("=======================%N")
			print ("Open browser to: http://localhost:8080%N%N")
			server.use_logging
			log_info ("server", "Logging middleware enabled")
			log_info ("server", "Calling server.start (blocking)...")
			server.start
		end

feature -- Server

	server: SIMPLE_WEB_SERVER
			-- HTTP server instance

feature {NONE} -- Route Registration

	register_routes
			-- Register all page routes
		do
			log_debug ("routes", "Registering page routes...")

			-- Landing page
			server.on_get ("/", agent handle_landing)
			log_debug ("routes", "  GET / -> handle_landing")

			-- Sub-pages (as we add them)
			server.on_get ("/get-started", agent handle_get_started)
			server.on_get ("/portfolio", agent handle_portfolio)
			server.on_get ("/business-case", agent handle_business_case)
			log_debug ("routes", "  GET /get-started, /portfolio, /business-case")

			-- Redirect .html extensions to clean URLs
			server.on_get ("/index.html", agent handle_redirect_home)
			server.on_get ("/get-started.html", agent handle_redirect_get_started)
			server.on_get ("/portfolio.html", agent handle_redirect_portfolio)
			server.on_get ("/business-case.html", agent handle_redirect_business_case)
			log_debug ("routes", "  Redirect routes for .html extensions")
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
			-- Serve the get started page (placeholder)
		do
			log_info ("handler", "Request for /get-started (placeholder)")
			res.send_html (placeholder_page ("Get Started", "Coming soon..."))
		end

	handle_portfolio (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the portfolio page (placeholder)
		do
			log_info ("handler", "Request for /portfolio (placeholder)")
			res.send_html (placeholder_page ("Project Portfolio", "Coming soon..."))
		end

	handle_business_case (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Serve the business case page (placeholder)
		do
			log_info ("handler", "Request for /business-case (placeholder)")
			res.send_html (placeholder_page ("Business Case", "Coming soon..."))
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

	handle_redirect_business_case (req: SIMPLE_WEB_SERVER_REQUEST; res: SIMPLE_WEB_SERVER_RESPONSE)
			-- Redirect to business-case
		do
			log_debug ("redirect", "/business-case.html -> /business-case")
			res.send_redirect ("/business-case")
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
