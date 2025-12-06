note
	description: "The Evidence section - Look what got built"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_EVIDENCE_SECTION

inherit
	SSC_SECTION
		redefine
			background_color
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize evidence section
		do
			-- Nothing needed
		end

feature -- Access

	section_number: INTEGER = 5

	section_id: STRING = "evidence"

	background_color: STRING
			-- Deep navy for evidence/proof
		do
			Result := color_accent_evidence
		end

feature {NONE} -- Content

	section_content: STRING
			-- Evidence section with project grid
		local
			l_container, l_label_wrap, l_header, l_grid, l_cta: ALPINE_DIV
			l_label: ALPINE_SPAN
			l_headline: ALPINE_H2
			l_subhead: ALPINE_P
		do
			create Result.make (8000)

			-- Main container
			l_container := alpine.div
			l_container.class_ (container_wide).do_nothing

			-- Section label
			l_label_wrap := alpine.div
			l_label_wrap.class_ ("mb-8").do_nothing

			l_label := alpine.span
			l_label.class_ (font_section_label)
				.text ("THE EVIDENCE")
				.do_nothing
			l_label_wrap.raw_html (l_label.to_html).do_nothing
			l_container.raw_html (l_label_wrap.to_html).do_nothing

			-- Header
			l_header := alpine.div
			l_header.class_ ("mb-12").do_nothing

			l_headline := alpine.h2
			l_headline.class_ (font_section_headline + " mb-4")
				.text ("This isn't theory.")
				.do_nothing
			l_header.raw_html (l_headline.to_html).do_nothing

			l_subhead := alpine.p
			l_subhead.class_ (font_body + " opacity-80")
				.text ("25 libraries + 4 apps built in 13 days. The Christmas Sprint: 14 libraries in 2 days.")
				.do_nothing
			l_header.raw_html (l_subhead.to_html).do_nothing

			l_container.raw_html (l_header.to_html).do_nothing

			-- Layer labels
			l_container.raw_html ("<p class=%"text-xs uppercase tracking-widest opacity-50 mb-4%">Foundation Layer</p>").do_nothing

			-- Foundation grid
			l_grid := alpine.div
			l_grid.class_ ("grid md:grid-cols-3 lg:grid-cols-4 gap-3 mb-8").do_nothing

			l_grid.raw_html (project_card ("simple_json", "11,400", "215", "JSON parsing/serialization", 1))
				.raw_html (project_card ("simple_base64", "", "", "RFC 4648 Base64 encoding", 2))
				.raw_html (project_card ("simple_hash", "", "", "MD5, SHA-1/256/512", 3))
				.raw_html (project_card ("simple_uuid", "", "", "UUID v4 generation", 4))
				.raw_html (project_card ("simple_csv", "", "", "CSV parsing/generation", 5))
				.raw_html (project_card ("simple_markdown", "", "", "Markdown to HTML", 6))
				.raw_html (project_card ("simple_validation", "", "", "Input validation rules", 7))
				.raw_html (project_card ("simple_process", "500", "4", "Process execution", 8))
				.raw_html (project_card ("simple_randomizer", "1,100", "27", "Random data generation", 9))
				.do_nothing
			l_container.raw_html (l_grid.to_html).do_nothing

			-- Service layer label
			l_container.raw_html ("<p class=%"text-xs uppercase tracking-widest opacity-50 mb-4%">Service Layer</p>").do_nothing

			-- Service grid
			l_grid := alpine.div
			l_grid.class_ ("grid md:grid-cols-3 lg:grid-cols-4 gap-3 mb-8").do_nothing

			l_grid.raw_html (project_card ("simple_sql", "17,200", "339", "SQLite query building", 1))
				.raw_html (project_card ("simple_jwt", "", "", "JWT token handling", 2))
				.raw_html (project_card ("simple_smtp", "", "", "Email sending", 3))
				.raw_html (project_card ("simple_cors", "", "", "CORS header handling", 4))
				.raw_html (project_card ("simple_rate_limiter", "", "", "Request rate limiting", 5))
				.raw_html (project_card ("simple_template", "", "", "Template rendering", 6))
				.raw_html (project_card ("simple_websocket", "", "", "WebSocket protocol", 7))
				.raw_html (project_card ("simple_cache", "", "", "LRU cache with TTL", 8))
				.raw_html (project_card ("simple_logger", "", "", "Structured JSON logging", 9))
				.do_nothing
			l_container.raw_html (l_grid.to_html).do_nothing

			-- Web layer label
			l_container.raw_html ("<p class=%"text-xs uppercase tracking-widest opacity-50 mb-4%">Web Layer</p>").do_nothing

			-- Web grid
			l_grid := alpine.div
			l_grid.class_ ("grid md:grid-cols-3 gap-3 mb-8").do_nothing

			l_grid.raw_html (project_card ("simple_web", "8,000", "95", "HTTP client + server", 1))
				.raw_html (project_card ("simple_htmx", "4,200", "40", "Fluent HTML/HTMX builder", 2))
				.raw_html (project_card ("simple_alpine", "3,200", "103", "Alpine.js directives", 3))
				.do_nothing
			l_container.raw_html (l_grid.to_html).do_nothing

			-- API Facades label
			l_container.raw_html ("<p class=%"text-xs uppercase tracking-widest opacity-50 mb-4%">API Facades</p>").do_nothing

			-- Facades grid
			l_grid := alpine.div
			l_grid.class_ ("grid md:grid-cols-3 gap-3 mb-8").do_nothing

			l_grid.raw_html (project_card ("simple_foundation_api", "", "", "Foundation layer unified", 1))
				.raw_html (project_card ("simple_service_api", "", "", "Service layer unified", 2))
				.raw_html (project_card ("simple_app_api", "", "", "Full stack unified", 3))
				.do_nothing
			l_container.raw_html (l_grid.to_html).do_nothing

			-- CTA
			l_cta := alpine.div
			l_cta.class_ ("mt-12 text-center")
				.raw_html ("<a href=%"portfolio%" class=%"inline-block px-6 py-3 bg-white/10 hover:bg-white/20 rounded-full text-sm transition-colors%">Explore the full portfolio →</a>")
				.do_nothing

			l_container.raw_html (l_cta.to_html).do_nothing

			Result.append (l_container.to_html)
		end

	project_card (a_name, a_lines, a_tests, a_desc: STRING; a_index: INTEGER): STRING
			-- Generate a project card HTML with GitHub link and entrance animation
		require
			name_not_empty: not a_name.is_empty
			desc_not_empty: not a_desc.is_empty
			index_positive: a_index > 0
		local
			l_card: ALPINE_DIV
			l_github_url: STRING
			l_delay_class: STRING
		do
			l_github_url := github_url (a_name)
			-- Stagger animation by cycling through delay classes
			l_delay_class := "card-delay-" + ((a_index - 1) \\ 4 + 1).out

			l_card := alpine.div
			l_card.class_ ("p-4 rounded-lg bg-white/5 hover:bg-white/10 hover-lift card-animate " + l_delay_class)
				.x_intersect ("$el.classList.add('entered')")
				.do_nothing

			l_card.raw_html ("<h3 class=%"font-mono text-sm font-medium mb-1%"><a href=%"" + l_github_url + "%" target=%"_blank%" class=%"hover:text-blue-400 transition-colors%">" + a_name + " ↗</a></h3>").do_nothing
			l_card.raw_html ("<p class=%"text-xs opacity-60 mb-2%">" + a_desc + "</p>").do_nothing
			if not a_lines.is_empty then
				l_card.raw_html ("<p class=%"text-xs%"><span class=%"opacity-50%">Lines:</span> <span class=%"font-bold%">" + a_lines + "</span></p>").do_nothing
			end
			if not a_tests.is_empty then
				l_card.raw_html ("<p class=%"text-xs%"><span class=%"opacity-50%">Tests:</span> <span class=%"font-bold%">" + a_tests + "</span></p>").do_nothing
			end
			Result := l_card.to_html
		ensure
			not_empty: not Result.is_empty
			has_name: Result.has_substring (a_name)
			has_github_link: Result.has_substring ("github.com")
		end

	github_url (a_project: STRING): STRING
			-- GitHub URL for project
		require
			project_not_empty: not a_project.is_empty
		do
			Result := "https://github.com/ljr1981/" + a_project
		ensure
			not_empty: not Result.is_empty
			is_github_url: Result.starts_with ("https://github.com/")
			has_project: Result.has_substring (a_project)
		end

end
