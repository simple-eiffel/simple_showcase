note
	description: "Design by Contract page - Technical explainer for developers"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_DBC_PAGE

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

	page_title: STRING = "How Design by Contract Works"

	page_subtitle: STRING = "The code tells you what it guarantees. The runtime enforces those guarantees. Automatically."

	page_url: STRING = "/design-by-contract"

feature -- Content

	page_content: STRING
			-- Main page content
		do
			create Result.make (15000)

			-- The Core Idea
			Result.append (section_heading ("The Core Idea"))
			Result.append (paragraph ("Every feature (method) is a contract between caller and implementation:"))
			Result.append ("<div class=%"space-y-4 mb-8%">%N")
			Result.append (contract_type_box ("PRECONDITIONS", "require",
				"What must be true before the feature runs",
				"%"I require these conditions to do my job.%""))
			Result.append (contract_type_box ("POSTCONDITIONS", "ensure",
				"What will be true after the feature runs",
				"%"I guarantee these results when I'm done.%""))
			Result.append (contract_type_box ("INVARIANTS", "invariant",
				"What's always true about an object",
				"%"This is always true about me, before and after every call.%""))
			Result.append ("</div>%N")
			Result.append (divider)

			-- A Real Example
			Result.append (section_heading ("A Real Example"))
			Result.append (paragraph ("Let's build a bank account:"))
			Result.append (code_block (bank_account_example))
			Result.append (paragraph ("What this guarantees:"))
			Result.append (bullet_list (<<
				"You can't withdraw zero or negative amounts",
				"You can't withdraw more than you have",
				"After withdrawal, balance is exactly what you expect",
				"Balance can never go negative, ever"
			>>))
			Result.append (paragraph ("<strong>Try to violate any of these?</strong> Runtime exception with exact location."))
			Result.append (divider)

			-- What Happens When AI Writes Code
			Result.append (section_heading ("What Happens When AI Writes Code"))
			Result.append ("<div class=%"grid md:grid-cols-2 gap-6 mb-8%">%N")
			Result.append (comparison_box ("Without Contracts", <<
				"AI writes withdraw function",
				"Maybe it checks for sufficient funds, maybe not",
				"Maybe there's a bug in the calculation",
				"You find out in production. Or you don't."
			>>, "text-red-400"))
			Result.append (comparison_box ("With Contracts", <<
				"AI writes withdraw function with contracts",
				"First test run: %"POSTCONDITION VIOLATION: balance_reduced%"",
				"Bug found instantly. Exact location. Exact expectation.",
				"AI fixes it. Contracts pass. Ship with confidence."
			>>, "text-emerald-400"))
			Result.append ("</div>%N")
			Result.append (paragraph ("The contracts are the specification. The runtime is the verifier. AI mistakes don't reach production."))
			Result.append (divider)

			-- Types of Contracts
			Result.append (section_heading ("Types of Contracts"))
			Result.append (contract_detail ("Preconditions (require)",
				"Guard inputs before execution. The caller's responsibility.",
				"require%N    positive_amount: amount > 0%N    sufficient_funds: amount <= balance"))
			Result.append (contract_detail ("Postconditions (ensure)",
				"Verify outputs after execution. The feature's promise.",
				"ensure%N    balance_reduced: balance = old balance - amount%N    non_negative: balance >= 0"))
			Result.append (contract_detail ("Class Invariants (invariant)",
				"Always true for the object. Checked after every public call.",
				"invariant%N    non_negative_balance: balance >= 0%N    valid_account_number: account_number.count = 10"))
			Result.append (contract_detail ("Check Assertions",
				"Mid-execution checks for debugging and documentation.",
				"check%N    valid_state: is_initialized%Nend"))
			Result.append (divider)

			-- The "old" Keyword
			Result.append (section_heading ("The %"old%" Keyword"))
			Result.append (paragraph ("One of the most powerful features: comparing before and after."))
			Result.append (code_block ("ensure%N    count_increased: items.count = old items.count + 1"))
			Result.append (paragraph ("<code>old items.count</code> captures the value BEFORE the feature ran. This lets you specify exactly how state should change."))
			Result.append (divider)

			-- Contracts vs Tests
			Result.append (section_heading ("Contracts vs. Tests"))
			Result.append ("<div class=%"grid md:grid-cols-2 gap-6 mb-8%">%N")
			Result.append ("<div class=%"card%">%N")
			Result.append ("  <h4 class=%"font-medium mb-2%">Tests</h4>%N")
			Result.append ("  <p class=%"text-sm opacity-70%">%"Here are some examples that should work.%"</p>%N")
			Result.append ("  <p class=%"text-sm opacity-70 mt-2%">Check specific cases.</p>%N")
			Result.append ("</div>%N")
			Result.append ("<div class=%"card%">%N")
			Result.append ("  <h4 class=%"font-medium mb-2%">Contracts</h4>%N")
			Result.append ("  <p class=%"text-sm opacity-70%">%"Here is what must ALWAYS be true.%"</p>%N")
			Result.append ("  <p class=%"text-sm opacity-70 mt-2%">Check every execution.</p>%N")
			Result.append ("</div>%N")
			Result.append ("</div>%N")
			Result.append (paragraph ("Tests are valuable. Contracts are comprehensive. Use both. But contracts catch what tests miss."))
			Result.append (divider)

			-- Why This Matters for AI
			Result.append (section_heading ("Why This Matters for AI"))
			Result.append (paragraph ("AI generates statistically likely code. %"Likely%" isn't %"correct.%""))
			Result.append (paragraph ("Contracts turn %"I hope this works%" into %"This is proven to work.%""))
			Result.append (paragraph ("<strong>That's the unlock.</strong>"))

			-- CTA
			Result.append ("<div class=%"mt-8 flex gap-4%">%N")
			Result.append (cta_button ("Get Started", "get-started"))
			Result.append (cta_button ("See the Evidence", "portfolio"))
			Result.append ("</div>%N")
		ensure then
			has_examples: Result.has_substring ("BANK_ACCOUNT")
		end

feature {NONE} -- Related Pages

	related_pages: HASH_TABLE [STRING, STRING]
			-- Related pages for footer
		do
			create Result.make (3)
			Result.put ("Probable to Provable", "probable-to-provable")
			Result.put ("The Workflow", "workflow")
		end

feature {NONE} -- Content Helpers

	bank_account_example: STRING
			-- Interactive bank account DBC demo
		do
			create Result.make (6000)

			-- Alpine.js container with step state
			Result.append ("<div x-data=%"{ step: 0, maxStep: 10 }%" class=%"space-y-4%">%N")

			-- Code block with highlighted sections
			Result.append ("<pre class=%"p-4 rounded-lg bg-[#1a1a1a] overflow-x-auto text-xs sm:text-sm font-mono leading-relaxed%"><code>")

			-- Class header
			Result.append ("<span :class=%"step === 1 ? 'bg-white/20' : ''%">class BANK_ACCOUNT</span>%N%N")

			-- Balance attribute
			Result.append ("<span :class=%"step === 2 ? 'bg-blue-400/20' : ''%">feature -- Access%N%N")
			Result.append ("    balance: DECIMAL%N")
			Result.append ("        -- Current account balance</span>%N%N")

			-- Feature header
			Result.append ("feature -- Operations%N%N")
			Result.append ("    withdraw (amount: DECIMAL)%N")
			Result.append ("        -- Withdraw amount from account%N")

			-- Preconditions
			Result.append ("<span :class=%"step === 3 ? 'bg-amber-400/20' : ''%">")
			Result.append ("        <span class=%"text-amber-400%">require</span>%N")
			Result.append ("            positive_amount: amount > 0%N")
			Result.append ("            sufficient_funds: amount <= balance</span>%N")

			-- Do block
			Result.append ("<span :class=%"step === 4 ? 'bg-blue-400/20' : ''%">")
			Result.append ("        <span class=%"text-blue-400%">do</span>%N")
			Result.append ("            balance := balance - amount</span>%N")

			-- Postconditions
			Result.append ("<span :class=%"step === 5 ? 'bg-emerald-400/20' : ''%">")
			Result.append ("        <span class=%"text-emerald-400%">ensure</span>%N")
			Result.append ("            balance_reduced: balance = old balance - amount</span>%N")
			Result.append ("        <span class=%"text-blue-400%">end</span>%N%N")

			-- Invariant
			Result.append ("<span :class=%"step === 6 ? 'bg-purple-400/20' : ''%">")
			Result.append ("<span class=%"text-purple-400%">invariant</span>%N")
			Result.append ("    non_negative_balance: balance >= 0</span>%N%N")

			Result.append ("end")
			Result.append ("</code></pre>%N")

			-- Execution simulation area (shows on steps 7-10)
			Result.append ("<div x-show=%"step >= 7%" x-transition class=%"p-4 rounded-lg bg-black/30 font-mono text-sm%">%N")

			-- Step 7: Create account
			Result.append ("<div x-show=%"step === 7%" class=%"text-blue-300%">")
			Result.append ("<span class=%"opacity-60%">Create:</span> account.balance := 100.00")
			Result.append ("</div>%N")

			-- Step 8: Valid withdrawal
			Result.append ("<div x-show=%"step === 8%">")
			Result.append ("<div class=%"text-blue-300%"><span class=%"opacity-60%">Call:</span> account.withdraw(30.00)</div>")
			Result.append ("<div class=%"text-amber-400%"><span class=%"opacity-60%">Check:</span> amount > 0 → 30 > 0 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("<div class=%"text-amber-400%"><span class=%"opacity-60%">Check:</span> amount <= balance → 30 <= 100 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("<div class=%"text-white%"><span class=%"opacity-60%">Execute:</span> balance := 100 - 30</div>")
			Result.append ("<div class=%"text-emerald-400%"><span class=%"opacity-60%">Verify:</span> balance = old balance - amount → 70 = 100 - 30 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("<div class=%"text-purple-400%"><span class=%"opacity-60%">Invariant:</span> balance >= 0 → 70 >= 0 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("</div>%N")

			-- Step 9: Overdraft attempt
			Result.append ("<div x-show=%"step === 9%">")
			Result.append ("<div class=%"text-blue-300%"><span class=%"opacity-60%">Call:</span> account.withdraw(<span class=%"text-red-400%">100.00</span>)</div>")
			Result.append ("<div class=%"text-amber-400%"><span class=%"opacity-60%">Check:</span> amount > 0 → 100 > 0 <span class=%"text-emerald-400%">✓</span></div>")
			Result.append ("<div class=%"text-red-400 font-bold animate-pulse%">")
			Result.append ("⚠ PRECONDITION VIOLATION: sufficient_funds%N")
			Result.append ("<span class=%"text-sm font-normal opacity-80%">100 > 70 (current balance) — overdraft prevented!</span>")
			Result.append ("</div>")
			Result.append ("</div>%N")

			-- Step 10: Negative amount attempt
			Result.append ("<div x-show=%"step === 10%">")
			Result.append ("<div class=%"text-blue-300%"><span class=%"opacity-60%">Call:</span> account.withdraw(<span class=%"text-red-400%">-50.00</span>)</div>")
			Result.append ("<div class=%"text-red-400 font-bold animate-pulse%">")
			Result.append ("⚠ PRECONDITION VIOLATION: positive_amount%N")
			Result.append ("<span class=%"text-sm font-normal opacity-80%">-50 is not > 0 — deposit disguised as withdrawal blocked!</span>")
			Result.append ("</div>")
			Result.append ("</div>%N")

			Result.append ("</div>%N")

			-- Explainer text area
			Result.append ("<div class=%"h-16 flex items-center justify-center%">%N")
			Result.append ("<p x-show=%"step === 0%" class=%"text-center text-sm opacity-70%">Click <span class=%"font-bold%">Step</span> to explore the bank account contracts</p>%N")
			Result.append ("<p x-show=%"step === 1%" x-transition class=%"text-center text-sm%">A simple bank account class</p>%N")
			Result.append ("<p x-show=%"step === 2%" x-transition class=%"text-center text-sm text-blue-400%">The <strong>balance</strong> attribute stores current funds</p>%N")
			Result.append ("<p x-show=%"step === 3%" x-transition class=%"text-center text-sm text-amber-400%"><strong>Preconditions:</strong> amount must be positive AND within available balance</p>%N")
			Result.append ("<p x-show=%"step === 4%" x-transition class=%"text-center text-sm text-blue-400%">The actual work — subtract amount from balance</p>%N")
			Result.append ("<p x-show=%"step === 5%" x-transition class=%"text-center text-sm text-emerald-400%"><strong>Postcondition:</strong> balance is exactly reduced by the amount</p>%N")
			Result.append ("<p x-show=%"step === 6%" x-transition class=%"text-center text-sm text-purple-400%"><strong>Invariant:</strong> balance can NEVER go negative — checked after every call</p>%N")
			Result.append ("<p x-show=%"step === 7%" x-transition class=%"text-center text-sm%">Let's create an account with $100...</p>%N")
			Result.append ("<p x-show=%"step === 8%" x-transition class=%"text-center text-sm text-emerald-400%">Valid withdrawal: all contracts satisfied!</p>%N")
			Result.append ("<p x-show=%"step === 9%" x-transition class=%"text-center text-sm text-red-400%">Overdraft attempt? <strong>Blocked by precondition!</strong></p>%N")
			Result.append ("<p x-show=%"step === 10%" x-transition class=%"text-center text-sm text-red-400%">Sneaky negative withdrawal? <strong>Also blocked!</strong></p>%N")
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
		end

	contract_type_box (a_title, a_keyword, a_description, a_quote: STRING): STRING
			-- Generate a contract type explanation box
		do
			create Result.make (300)
			Result.append ("<div class=%"card%">%N")
			Result.append ("  <h4 class=%"font-medium mb-1%">" + a_title + " (<code>" + a_keyword + "</code>)</h4>%N")
			Result.append ("  <p class=%"text-sm opacity-70 mb-2%">" + a_description + "</p>%N")
			Result.append ("  <p class=%"text-sm italic opacity-60%">" + a_quote + "</p>%N")
			Result.append ("</div>%N")
		end

	comparison_box (a_title: STRING; a_items: ARRAY [STRING]; a_color: STRING): STRING
			-- Generate a comparison box
		do
			create Result.make (400)
			Result.append ("<div class=%"card%">%N")
			Result.append ("  <h4 class=%"font-medium mb-4 " + a_color + "%">" + a_title + "</h4>%N")
			Result.append ("  <ul class=%"text-sm space-y-2%">%N")
			across 1 |..| a_items.count as idx loop
				Result.append ("    <li class=%"opacity-80%">• " + a_items[idx.item] + "</li>%N")
			end
			Result.append ("  </ul>%N")
			Result.append ("</div>%N")
		end

	contract_detail (a_title, a_description, a_example: STRING): STRING
			-- Generate a detailed contract explanation
		do
			create Result.make (400)
			Result.append ("<div class=%"mb-6%">%N")
			Result.append ("  <h4 class=%"font-medium mb-2%">" + a_title + "</h4>%N")
			Result.append ("  <p class=%"text-sm opacity-80 mb-3%">" + a_description + "</p>%N")
			Result.append (code_block (a_example))
			Result.append ("</div>%N")
		end

end
