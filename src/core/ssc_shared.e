note
	description: "Shared constants and utilities for Simple Showcase"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_SHARED

feature -- Color Palette

	color_primary_dark: STRING = "#0c0b0b"
			-- Deep charcoal - main background

	color_primary_light: STRING = "#fdfcfa"
			-- Off-white - primary text

	color_accent_calm: STRING = "#0d4f4f"
			-- Deep teal - unlock/solution sections

	color_accent_warning: STRING = "#4f2d0d"
			-- Deep amber - problem sections

	color_accent_energy: STRING = "#2d0d4f"
			-- Deep purple - shift/excitement sections

	color_accent_evidence: STRING = "#0d1a4f"
			-- Deep navy - evidence/proof sections

	color_code_bg: STRING = "#1a1a1a"
			-- Near-black - code blocks

	color_code_text: STRING = "#8fdf8f"
			-- Soft green - code syntax

feature -- Typography Classes

	font_hero_headline: STRING = "text-[8vw] font-light tracking-[-0.02em]"

	font_section_headline: STRING = "text-[5vw] font-medium"

	font_body: STRING = "text-lg leading-relaxed"

	font_section_label: STRING = "text-xs uppercase tracking-widest opacity-60"

	font_code: STRING = "font-mono text-sm leading-relaxed"

	font_stats: STRING = "font-bold tabular-nums"

feature -- Animation Classes

	anim_text_reveal: STRING = "transition-all duration-700 ease-out"

	anim_card_entrance: STRING = "transition-all duration-500 ease-out"

	anim_hover: STRING = "transition-all duration-200 ease"

	anim_scroll_indicator: STRING = "animate-bounce"

feature -- Common Classes

	section_full_viewport: STRING = "min-h-screen w-full snap-start flex flex-col justify-center items-center px-8"

	container_centered: STRING = "max-w-4xl mx-auto text-center"

	container_wide: STRING = "max-w-6xl mx-auto"

feature -- Base URL (for GitHub Pages)

	base_url: STRING = "/simple_showcase"
			-- Base URL path for GitHub Pages deployment
			-- Use empty string for localhost, "/simple_showcase" for GitHub Pages

	base_tag: STRING
			-- HTML base tag for proper link resolution
		do
			Result := "<base href=%"" + base_url + "/%">"
		ensure
			not_empty: not Result.is_empty
		end

feature -- CDN URLs

	tailwind_cdn: STRING = "https://cdn.tailwindcss.com"

	alpine_cdn: STRING = "https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"

	alpine_intersect_cdn: STRING = "https://cdn.jsdelivr.net/npm/@alpinejs/intersect@3.x.x/dist/cdn.min.js"

	alpine_collapse_cdn: STRING = "https://cdn.jsdelivr.net/npm/@alpinejs/collapse@3.x.x/dist/cdn.min.js"

	lenis_cdn: STRING = "https://cdn.jsdelivr.net/npm/@studio-freight/lenis@1.0.42/dist/lenis.min.js"

invariant
	-- Color palette is valid hex format
	valid_primary_dark: color_primary_dark.starts_with ("#") and color_primary_dark.count = 7
	valid_primary_light: color_primary_light.starts_with ("#") and color_primary_light.count = 7
	valid_accent_calm: color_accent_calm.starts_with ("#") and color_accent_calm.count = 7
	valid_accent_warning: color_accent_warning.starts_with ("#") and color_accent_warning.count = 7
	valid_accent_energy: color_accent_energy.starts_with ("#") and color_accent_energy.count = 7
	valid_accent_evidence: color_accent_evidence.starts_with ("#") and color_accent_evidence.count = 7
	valid_code_bg: color_code_bg.starts_with ("#") and color_code_bg.count = 7
	valid_code_text: color_code_text.starts_with ("#") and color_code_text.count = 7

	-- CDN URLs are valid https
	tailwind_https: tailwind_cdn.starts_with ("https://")
	alpine_https: alpine_cdn.starts_with ("https://")
	alpine_intersect_https: alpine_intersect_cdn.starts_with ("https://")

end
