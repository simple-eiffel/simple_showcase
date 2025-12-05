note
	description: "The Unlock section - Contracts verify AI"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_UNLOCK_SECTION

inherit
	SSC_SECTION
		redefine
			background_color
		end

	SSC_GLOSSARY

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize unlock section
		do
			-- Nothing needed
		end

feature -- Access

	section_number: INTEGER = 4

	section_id: STRING = "unlock"

	background_color: STRING
			-- Deep teal for solution/calm
		do
			Result := color_accent_calm
		end

feature {NONE} -- Content

	section_content: STRING
			-- Unlock section with code example
		local
			l_container, l_label_wrap, l_content, l_code_block: ALPINE_DIV
			l_label: ALPINE_SPAN
			l_headline: ALPINE_H2
			l_subhead, l_explanation: ALPINE_P
		do
			create Result.make (5000)

			-- Main container
			l_container := alpine.div
			l_container.class_ (container_wide).do_nothing

			-- Section label
			l_label_wrap := alpine.div
			l_label_wrap.class_ ("mb-8").do_nothing

			l_label := alpine.span
			l_label.class_ (font_section_label)
				.text ("THE UNLOCK")
				.do_nothing
			l_label_wrap.raw_html (l_label.to_html).do_nothing
			l_container.raw_html (l_label_wrap.to_html).do_nothing

			-- Content
			l_content := alpine.div
			l_content.class_ ("grid lg:grid-cols-2 gap-12 items-center").do_nothing

			-- Left: Text
			l_label_wrap := alpine.div

			l_headline := alpine.h2
			l_headline.class_ (font_section_headline + " mb-6")
				.text ("What if the code could verify itself?")
				.do_nothing
			l_label_wrap.raw_html (l_headline.to_html).do_nothing

			l_subhead := alpine.p
			l_subhead.class_ (font_body + " opacity-90 mb-4")
				.raw_html (term_design_by_contract + " embeds verification into every feature. The compiler becomes your QA department.")
				.do_nothing
			l_label_wrap.raw_html (l_subhead.to_html).do_nothing

			l_explanation := alpine.p
			l_explanation.class_ (font_body + " opacity-70")
				.raw_html (term_preconditions + " guard inputs. " + term_postconditions + " verify outputs. " + term_invariants + " maintain state. Every " + term_contract_violation + " is caught immediately—not in production.")
				.do_nothing
			l_label_wrap.raw_html (l_explanation.to_html).do_nothing

			l_content.raw_html (l_label_wrap.to_html).do_nothing

			-- Right: Code example
			l_code_block := alpine.div
			l_code_block.raw_html (code_example).do_nothing

			l_content.raw_html (l_code_block.to_html).do_nothing

			l_container.raw_html (l_content.to_html).do_nothing

			Result.append (l_container.to_html)
		end

	code_example: STRING
			-- Interactive stepped Eiffel DBC demo
		do
			create Result.make (5000)

			-- Alpine.js container with step state
			Result.append ("<div x-data=%"{ step: 0, maxStep: 8 }%" class=%"space-y-4%">%N")

			-- Code block with highlighted lines based on step
			Result.append ("<pre class=%"p-6 rounded-lg bg-[" + color_code_bg + "] overflow-x-auto relative%"><code class=%"" + font_code + " text-[" + color_code_text + "]%">")

			-- Line 1: Function signature
			Result.append ("<span :class=%"step === 1 ? 'bg-white/20 -mx-2 px-2' : ''%">")
			Result.append ("divide (a, b: REAL): REAL</span>%N")

			-- Line 2-3: Precondition
			Result.append ("<span :class=%"step === 2 ? 'bg-amber-400/20 -mx-2 px-2' : ''%">")
			Result.append ("  <span class=%"text-amber-400%">require</span>%N")
			Result.append ("    positive_divisor: b > 0</span>%N")

			-- Line 4-5: Do block
			Result.append ("<span :class=%"step === 3 ? 'bg-blue-400/20 -mx-2 px-2' : ''%">")
			Result.append ("  <span class=%"text-blue-400%">do</span>%N")
			Result.append ("    Result := a / b</span>%N")

			-- Line 6-7: Postcondition
			Result.append ("<span :class=%"step === 4 ? 'bg-emerald-400/20 -mx-2 px-2' : ''%">")
			Result.append ("  <span class=%"text-emerald-400%">ensure</span>%N")
			Result.append ("    correct_result: Result * b = a</span>%N")

			-- Line 8: End
			Result.append ("  <span class=%"text-blue-400%">end</span>")
			Result.append ("</code></pre>%N")

			-- Execution simulation area (shows on steps 5-8)
			Result.append ("<div x-show=%"step >= 5%" x-transition class=%"p-4 rounded-lg bg-black/30 font-mono text-sm%">%N")

			-- Step 5: Valid call
			Result.append ("<div x-show=%"step === 5%" class=%"text-blue-300%">")
			Result.append ("<span class=%"opacity-60%">Call:</span> divide(10, 2)")
			Result.append ("</div>%N")

			-- Step 6: Precondition check passes
			Result.append ("<div x-show=%"step === 6%">")
			Result.append ("<div class=%"text-blue-300%"><span class=%"opacity-60%">Call:</span> divide(10, 2)</div>")
			Result.append ("<div class=%"text-amber-400%"><span class=%"opacity-60%">Check:</span> b > 0 → 2 > 0 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("</div>%N")

			-- Step 7: Result with postcondition
			Result.append ("<div x-show=%"step === 7%">")
			Result.append ("<div class=%"text-blue-300%"><span class=%"opacity-60%">Call:</span> divide(10, 2)</div>")
			Result.append ("<div class=%"text-amber-400%"><span class=%"opacity-60%">Check:</span> b > 0 → 2 > 0 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("<div class=%"text-white%"><span class=%"opacity-60%">Result:</span> 5.0</div>")
			Result.append ("<div class=%"text-emerald-400%"><span class=%"opacity-60%">Verify:</span> 5 × 2 = 10 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("</div>%N")

			-- Step 8: Invalid call - contract violation
			Result.append ("<div x-show=%"step === 8%">")
			Result.append ("<div class=%"text-blue-300%"><span class=%"opacity-60%">Call:</span> divide(10, <span class=%"text-red-400%">0</span>)</div>")
			Result.append ("<div class=%"text-red-400 font-bold animate-pulse%">")
			Result.append ("⚠ PRECONDITION VIOLATION: positive_divisor%N")
			Result.append ("<span class=%"text-sm font-normal opacity-80%">Caught immediately — not at 3am in production!</span>")
			Result.append ("</div>")
			Result.append ("</div>%N")

			Result.append ("</div>%N")

			-- Explainer text area
			Result.append ("<div class=%"h-16 flex items-center justify-center%">%N")
			Result.append ("<p x-show=%"step === 0%" class=%"text-center text-sm opacity-70%">Click <span class=%"font-bold%">Step</span> to walk through Design by Contract</p>%N")
			Result.append ("<p x-show=%"step === 1%" x-transition class=%"text-center text-sm%">A simple division function with two inputs</p>%N")
			Result.append ("<p x-show=%"step === 2%" x-transition class=%"text-center text-sm text-amber-400%">The <strong>precondition</strong>: caller promises b will be positive</p>%N")
			Result.append ("<p x-show=%"step === 3%" x-transition class=%"text-center text-sm text-blue-400%">The actual work — just one line of code</p>%N")
			Result.append ("<p x-show=%"step === 4%" x-transition class=%"text-center text-sm text-emerald-400%">The <strong>postcondition</strong>: function guarantees correct math</p>%N")
			Result.append ("<p x-show=%"step === 5%" x-transition class=%"text-center text-sm%">Let's call it with valid input...</p>%N")
			Result.append ("<p x-show=%"step === 6%" x-transition class=%"text-center text-sm text-amber-400%">Precondition checked first — b=2 satisfies b > 0</p>%N")
			Result.append ("<p x-show=%"step === 7%" x-transition class=%"text-center text-sm text-emerald-400%">Postcondition verified — the math is correct!</p>%N")
			Result.append ("<p x-show=%"step === 8%" x-transition class=%"text-center text-sm text-red-400%">Invalid input? Contract catches it <strong>immediately</strong>.</p>%N")
			Result.append ("</div>%N")

			-- Navigation buttons
			Result.append ("<div class=%"flex items-center justify-center gap-4%">%N")
			Result.append ("<button @click=%"step = Math.max(0, step - 1)%" ")
			Result.append (":disabled=%"step === 0%" ")
			Result.append ("class=%"px-4 py-2 rounded bg-white/10 hover:bg-white/20 disabled:opacity-30 disabled:cursor-not-allowed transition-all%">")
			Result.append ("← Back</button>%N")

			Result.append ("<span class=%"text-sm opacity-60%" x-text=%"step + '/' + maxStep%"></span>%N")

			Result.append ("<button @click=%"step = Math.min(maxStep, step + 1)%" ")
			Result.append (":disabled=%"step === maxStep%" ")
			Result.append ("class=%"px-4 py-2 rounded bg-white/10 hover:bg-white/20 disabled:opacity-30 disabled:cursor-not-allowed transition-all%">")
			Result.append ("<span x-show=%"step === 0%">Step</span>")
			Result.append ("<span x-show=%"step > 0 && step < maxStep%">Next →</span>")
			Result.append ("<span x-show=%"step === maxStep%">Done ✓</span>")
			Result.append ("</button>%N")

			Result.append ("<button x-show=%"step > 0%" @click=%"step = 0%" ")
			Result.append ("class=%"px-4 py-2 rounded bg-white/5 hover:bg-white/10 text-sm opacity-60 transition-all%">")
			Result.append ("Reset</button>%N")

			Result.append ("</div>%N")
			Result.append ("</div>%N")
		ensure
			not_empty: not Result.is_empty
			has_alpine: Result.has_substring ("x-data")
			has_require: Result.has_substring ("require")
			has_ensure: Result.has_substring ("ensure")
		end

end
