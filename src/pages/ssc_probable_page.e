note
	description: "Probable to Provable page - Meyer's framework explained"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_PROBABLE_PAGE

inherit
	SSC_SUB_PAGE
		redefine
			related_pages
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize page
		do
			-- Nothing needed
		end

feature -- Access

	page_title: STRING = "From Probable to Provable"

	page_subtitle: STRING = "The framework for AI-assisted development that actually works."

	page_url: STRING = "/probable-to-provable"

feature -- Content

	page_content: STRING
			-- Main page content
		do
			create Result.make (12000)

			-- Attribution
			Result.append (paragraph ("<em>Inspired by Bertrand Meyer's work on Design by Contract and software verification.</em>"))
			Result.append (divider)

			-- The Core Insight
			Result.append (section_heading ("The Core Insight"))
			Result.append (paragraph ("AI produces statistically likely code. Not proven correct code. <strong>Likely code.</strong>"))
			Result.append (paragraph ("%"Likely%" works for one module. %"Likely%" fails at scale."))
			Result.append (divider)

			-- The Math
			Result.append (section_heading ("The Math"))
			Result.append (paragraph ("If each module is 99.9%% correct:"))
			Result.append ("<div class=%"bg-[#1a1a1a] rounded-lg p-6 mb-8 font-mono text-sm%">%N")
			Result.append ("  <div class=%"grid grid-cols-2 gap-4%">%N")
			Result.append (probability_row ("100 modules", "0.999^100", "90.5%%"))
			Result.append (probability_row ("500 modules", "0.999^500", "60.6%%"))
			Result.append (probability_row ("1,000 modules", "0.999^1000", "36.8%%"))
			Result.append (probability_row ("5,000 modules", "0.999^5000", "0.7%%"))
			Result.append ("  </div>%N")
			Result.append ("</div>%N")
			Result.append (paragraph ("Real systems have thousands of modules. %"Probably correct%" becomes %"probably broken.%""))
			Result.append (divider)

			-- The Solution
			Result.append (section_heading ("The Solution"))
			Result.append (paragraph ("Combine AI generation with formal verification."))
			Result.append ("<div class=%"grid md:grid-cols-2 gap-6 mb-8%">%N")
			Result.append ("<div class=%"card%">%N")
			Result.append ("  <h4 class=%"font-medium mb-2 text-blue-400%">AI Generates</h4>%N")
			Result.append ("  <p class=%"text-sm opacity-70%">Fast, bulk, pattern-matching</p>%N")
			Result.append ("</div>%N")
			Result.append ("<div class=%"card%">%N")
			Result.append ("  <h4 class=%"font-medium mb-2 text-emerald-400%">Contracts Verify</h4>%N")
			Result.append ("  <p class=%"text-sm opacity-70%">Complete, automatic, every execution</p>%N")
			Result.append ("</div>%N")
			Result.append ("</div>%N")
			Result.append (paragraph ("<strong>Probable + Verification = Provable</strong>"))
			Result.append (divider)

			-- The Process
			Result.append (section_heading ("The Process"))
			Result.append (process_step ("1", "SPECIFICATION",
				"Write contracts BEFORE implementation. Define what must be true."))
			Result.append (process_step ("2", "GENERATION",
				"AI generates implementation to satisfy contracts. Fast, bulk, pattern-based."))
			Result.append (process_step ("3", "VERIFICATION",
				"Compiler checks types. Runtime checks contracts. Tests check scenarios."))
			Result.append (process_step ("4", "ITERATION",
				"Contract violation? Fix spec or implementation. Repeat until correct."))
			Result.append (divider)

			-- The "True But Incomplete" Trap
			Result.append (section_heading ("The %"True But Incomplete%" Trap"))
			Result.append (paragraph ("AI often generates contracts that are true but miss guarantees. Step through this example:"))
			Result.append (incomplete_contract_demo)
			Result.append (paragraph ("<strong>Always ask: %"What ELSE is guaranteed?%"</strong>"))
			Result.append (divider)

			-- The Implication
			Result.append (section_heading ("The Implication"))
			Result.append (paragraph ("AI without verification: <strong>Faster bugs at scale.</strong>"))
			Result.append (paragraph ("AI with verification: <strong>Faster correctness at scale.</strong>"))
			Result.append (paragraph ("The technology for verification exists. It's called Design by Contract. It's built into Eiffel."))

			-- CTA
			Result.append ("<div class=%"mt-8 flex gap-4%">%N")
			Result.append (cta_button ("How DBC Works", "design-by-contract"))
			Result.append (cta_button ("Get Started", "get-started"))
			Result.append ("</div>%N")
		ensure then
			has_math: Result.has_substring ("0.999")
		end

feature {NONE} -- Related Pages

	related_pages: HASH_TABLE [STRING, STRING]
			-- Related pages for footer
		do
			create Result.make (3)
			Result.put ("Design by Contract", "design-by-contract")
			Result.put ("What AI Changes", "ai-changes")
		end

feature {NONE} -- Content Helpers

	probability_row (a_modules, a_formula, a_result: STRING): STRING
			-- Generate a probability calculation row
		do
			create Result.make (200)
			Result.append ("    <div class=%"opacity-70%">" + a_modules + "</div>%N")
			Result.append ("    <div><span class=%"opacity-50%">" + a_formula + " = </span><span class=%"text-amber-400%">" + a_result + "</span></div>%N")
		end

	process_step (a_number, a_title, a_description: STRING): STRING
			-- Generate a process step
		do
			create Result.make (300)
			Result.append ("<div class=%"mb-6 flex gap-4%">%N")
			Result.append ("  <div class=%"text-3xl font-bold opacity-20%">" + a_number + "</div>%N")
			Result.append ("  <div>%N")
			Result.append ("    <h4 class=%"font-medium mb-1%">" + a_title + "</h4>%N")
			Result.append ("    <p class=%"text-sm opacity-70%">" + a_description + "</p>%N")
			Result.append ("  </div>%N")
			Result.append ("</div>%N")
		end

	incomplete_contract_demo: STRING
			-- Interactive demo showing AI's incomplete contracts vs complete ones
		do
			create Result.make (4000)

			-- Alpine.js container
			Result.append ("<div x-data=%"{ step: 0, maxStep: 6 }%" class=%"space-y-4 mb-8%">%N")

			-- Side by side code blocks
			Result.append ("<div class=%"grid md:grid-cols-2 gap-4%">%N")

			-- Left: AI's incomplete version
			Result.append ("<div class=%"card%">%N")
			Result.append ("<h4 class=%"font-medium mb-2 text-amber-400%">AI might write:</h4>%N")
			Result.append ("<pre class=%"p-4 rounded bg-black/30 text-xs sm:text-sm font-mono%"><code>")
			Result.append ("add_item (a_item: ITEM)%N")
			Result.append ("    <span class=%"text-blue-400%">do</span>%N")
			Result.append ("        items.extend (a_item)%N")
			Result.append ("<span :class=%"step >= 1 ? 'bg-amber-400/30' : 'opacity-50'%">")
			Result.append ("    <span class=%"text-emerald-400%">ensure</span>%N")
			Result.append ("        has_item: items.has (a_item)</span>%N")
			Result.append ("    <span class=%"text-blue-400%">end</span>")
			Result.append ("</code></pre>%N")
			Result.append ("<p x-show=%"step >= 2%" x-transition class=%"text-xs text-amber-400 mt-2%">✓ True... but what about count?</p>%N")
			Result.append ("</div>%N")

			-- Right: Complete version
			Result.append ("<div class=%"card%">%N")
			Result.append ("<h4 class=%"font-medium mb-2 text-emerald-400%">Complete contract:</h4>%N")
			Result.append ("<pre class=%"p-4 rounded bg-black/30 text-xs sm:text-sm font-mono%"><code>")
			Result.append ("add_item (a_item: ITEM)%N")
			Result.append ("    <span class=%"text-blue-400%">do</span>%N")
			Result.append ("        items.extend (a_item)%N")
			Result.append ("<span :class=%"step >= 3 ? 'bg-emerald-400/30' : 'opacity-50'%">")
			Result.append ("    <span class=%"text-emerald-400%">ensure</span>%N")
			Result.append ("        has_item: items.has (a_item)%N")
			Result.append ("<span :class=%"step >= 4 ? 'bg-emerald-400/30' : ''%">")
			Result.append ("        count_increased: items.count = old items.count + 1</span>%N")
			Result.append ("<span :class=%"step >= 5 ? 'bg-emerald-400/30' : ''%">")
			Result.append ("        only_one_added: items.occurrences (a_item) = old items.occurrences (a_item) + 1</span></span>%N")
			Result.append ("    <span class=%"text-blue-400%">end</span>")
			Result.append ("</code></pre>%N")
			Result.append ("<p x-show=%"step >= 5%" x-transition class=%"text-xs text-emerald-400 mt-2%">✓ Complete: item added, count grew, exactly one copy added</p>%N")
			Result.append ("</div>%N")

			Result.append ("</div>%N")

			-- Bug demonstration area
			Result.append ("<div x-show=%"step === 6%" x-transition class=%"p-4 rounded-lg bg-red-900/20 border border-red-400/30%">%N")
			Result.append ("<p class=%"text-sm text-red-400 font-medium mb-2%">⚠ The incomplete contract misses bugs:</p>%N")
			Result.append ("<div class=%"font-mono text-xs space-y-1%">%N")
			Result.append ("<div class=%"opacity-80%">• AI accidentally adds item twice → <span class=%"text-amber-400%">has_item still passes!</span></div>%N")
			Result.append ("<div class=%"opacity-80%">• AI forgets to actually add → <span class=%"text-red-400%">only caught if has_item checked</span></div>%N")
			Result.append ("<div class=%"opacity-80%">• Complete contract catches BOTH immediately</div>%N")
			Result.append ("</div>%N")
			Result.append ("</div>%N")

			-- Explainer text
			Result.append ("<div class=%"h-12 flex items-center justify-center%">%N")
			Result.append ("<p x-show=%"step === 0%" class=%"text-center text-sm opacity-70%">Click <span class=%"font-bold%">Step</span> to see the difference</p>%N")
			Result.append ("<p x-show=%"step === 1%" x-transition class=%"text-center text-sm text-amber-400%">AI writes a postcondition: %"the item is in the list%"</p>%N")
			Result.append ("<p x-show=%"step === 2%" x-transition class=%"text-center text-sm%">This is TRUE... but is it COMPLETE?</p>%N")
			Result.append ("<p x-show=%"step === 3%" x-transition class=%"text-center text-sm text-emerald-400%">Complete contract also verifies the same thing...</p>%N")
			Result.append ("<p x-show=%"step === 4%" x-transition class=%"text-center text-sm text-emerald-400%">PLUS: the count increased by exactly 1</p>%N")
			Result.append ("<p x-show=%"step === 5%" x-transition class=%"text-center text-sm text-emerald-400%">PLUS: only ONE copy was added (not duplicates)</p>%N")
			Result.append ("<p x-show=%"step === 6%" x-transition class=%"text-center text-sm text-red-400%">The incomplete contract misses real bugs!</p>%N")
			Result.append ("</div>%N")

			-- Navigation
			Result.append ("<div class=%"flex items-center justify-center gap-4%">%N")
			Result.append ("<button @click=%"step = Math.max(0, step - 1)%" :disabled=%"step === 0%" ")
			Result.append ("class=%"px-4 py-2 rounded bg-white/10 hover:bg-white/20 disabled:opacity-30 disabled:cursor-not-allowed transition-all%">← Back</button>%N")
			Result.append ("<span class=%"text-sm opacity-60%" x-text=%"step + '/' + maxStep%"></span>%N")
			Result.append ("<button @click=%"step = Math.min(maxStep, step + 1)%" :disabled=%"step === maxStep%" ")
			Result.append ("class=%"px-4 py-2 rounded bg-white/10 hover:bg-white/20 disabled:opacity-30 disabled:cursor-not-allowed transition-all%">")
			Result.append ("<span x-show=%"step === 0%">Step</span><span x-show=%"step > 0 && step < maxStep%">Next →</span><span x-show=%"step === maxStep%">Done ✓</span></button>%N")
			Result.append ("<button x-show=%"step > 0%" @click=%"step = 0%" class=%"px-4 py-2 rounded bg-white/5 hover:bg-white/10 text-sm opacity-60 transition-all%">Reset</button>%N")
			Result.append ("</div>%N")

			Result.append ("</div>%N")
		end

end
