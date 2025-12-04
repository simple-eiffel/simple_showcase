note
	description: "[
		Glossary tooltips for technical terms.

		Provides hover-reveal definitions for terms that may be unfamiliar
		to developers who haven't encountered Design by Contract or Eiffel.

		Usage:
			inherit SSC_GLOSSARY
			...
			text ("This uses " + term_design_by_contract + " for verification.")
	]"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_GLOSSARY

feature -- Term Tooltips

	term_design_by_contract: STRING
			-- "Design by Contract" with tooltip
		do
			Result := tooltip ("Design by Contract",
				"A methodology where code explicitly declares what it requires (preconditions) and guarantees (postconditions)")
		ensure
			not_empty: not Result.is_empty
			has_term: Result.has_substring ("Design by Contract")
		end

	term_precondition: STRING
			-- "Precondition" with tooltip
		do
			Result := tooltip ("Precondition",
				"A condition that must be true before a feature executes. Guards against invalid inputs.")
		end

	term_preconditions: STRING
			-- "Preconditions" with tooltip
		do
			Result := tooltip ("Preconditions",
				"Conditions that must be true before a feature executes. Guard against invalid inputs.")
		end

	term_postcondition: STRING
			-- "Postcondition" with tooltip
		do
			Result := tooltip ("Postcondition",
				"A condition guaranteed to be true after a feature executes. The function's promise to its caller.")
		end

	term_postconditions: STRING
			-- "Postconditions" with tooltip
		do
			Result := tooltip ("Postconditions",
				"Conditions guaranteed to be true after a feature executes. The function's promises to its caller.")
		end

	term_invariant: STRING
			-- "Invariant" with tooltip
		do
			Result := tooltip ("Invariant",
				"A condition that must always be true for an object, checked after every public operation.")
		end

	term_invariants: STRING
			-- "Invariants" with tooltip
		do
			Result := tooltip ("Invariants",
				"Conditions that must always be true for an object, checked after every public operation.")
		end

	term_contract: STRING
			-- "Contract" with tooltip
		do
			Result := tooltip ("contract",
				"A formal specification of what code requires and guarantees, enforced at runtime.")
		end

	term_contracts: STRING
			-- "Contracts" with tooltip
		do
			Result := tooltip ("contracts",
				"Formal specifications of what code requires and guarantees, enforced at runtime.")
		end

	term_eiffel: STRING
			-- "Eiffel" with tooltip
		do
			Result := tooltip ("Eiffel",
				"A programming language designed by Bertrand Meyer with built-in Design by Contract since 1986.")
		end

	term_contract_violation: STRING
			-- "Contract violation" with tooltip
		do
			Result := tooltip ("contract violation",
				"When code breaks a precondition, postcondition, or invariant—immediately caught at runtime.")
		end

feature -- Tooltip Generation

	tooltip (a_term, a_definition: STRING): STRING
			-- Generate HTML for a term with hover tooltip
		require
			term_not_empty: not a_term.is_empty
			definition_not_empty: not a_definition.is_empty
		do
			create Result.make (300)
			Result.append ("<span class=%"tooltip-term%">")
			Result.append (a_term)
			Result.append ("<span class=%"tooltip-icon%">?</span>")
			Result.append ("<span class=%"tooltip-content%">")
			Result.append (a_definition)
			Result.append ("</span>")
			Result.append ("</span>")
		ensure
			not_empty: not Result.is_empty
			has_term: Result.has_substring (a_term)
			has_definition: Result.has_substring (a_definition)
			has_tooltip_structure: Result.has_substring ("tooltip-term") and Result.has_substring ("tooltip-content")
		end

feature -- CSS (to be included in page head)

	tooltip_css: STRING
			-- CSS styles for tooltips
		do
			create Result.make (800)
			Result.append (".tooltip-term { position: relative; cursor: help; border-bottom: 1px dotted currentColor; }%N")
			Result.append (".tooltip-icon { display: inline-flex; align-items: center; justify-content: center; width: 14px; height: 14px; margin-left: 2px; font-size: 10px; font-weight: bold; border: 1px solid currentColor; border-radius: 50%%; opacity: 0.6; vertical-align: super; }%N")
			Result.append (".tooltip-content { visibility: hidden; opacity: 0; position: absolute; bottom: 100%%; left: 50%%; transform: translateX(-50%%) translateY(-8px); width: 280px; padding: 12px 16px; background: #1a1a1a; color: #fdfcfa; font-size: 14px; line-height: 1.5; border-radius: 8px; box-shadow: 0 4px 20px rgba(0,0,0,0.4); z-index: 100; transition: opacity 0.2s, visibility 0.2s; pointer-events: none; }%N")
			Result.append (".tooltip-content::after { content: ''; position: absolute; top: 100%%; left: 50%%; transform: translateX(-50%%); border: 8px solid transparent; border-top-color: #1a1a1a; }%N")
			Result.append (".tooltip-term:hover .tooltip-content { visibility: visible; opacity: 1; }%N")
		ensure
			not_empty: not Result.is_empty
			has_tooltip_term_style: Result.has_substring (".tooltip-term")
			has_tooltip_content_style: Result.has_substring (".tooltip-content")
			has_hover_behavior: Result.has_substring (":hover")
		end

end
