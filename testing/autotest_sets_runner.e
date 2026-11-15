note
	description: "[
		Runs the tests in simple_showcase's AutoTest test sets that TEST_APP did not call
		(port-coordination #17: 5 of them ran in no gate). Each goes through AutoTest's own
		EQA_TEST_EVALUATOR: a fresh test set (on_prepare), the test, then clean (on_clean),
		as AutoTest runs it. A failing test prints "FAIL:" with its tag and is counted.
	]"

class
	AUTOTEST_SETS_RUNNER

feature -- Counts

	passed, failed: INTEGER
			-- Tests run here.

feature -- Running

	run_all
			-- Every test below, 5 in all.
		do
			run_lib_tests
		end

feature {NONE} -- Test sets

	run_lib_tests
		local
			l_evaluator: EQA_TEST_EVALUATOR [LIB_TESTS]
		do
			create l_evaluator
			report (l_evaluator.execute (agent {LIB_TESTS}.test_config_make_default), "LIB_TESTS.test_config_make_default")
			report (l_evaluator.execute (agent {LIB_TESTS}.test_site_generator_make), "LIB_TESTS.test_site_generator_make")
			report (l_evaluator.execute (agent {LIB_TESTS}.test_landing_page_make), "LIB_TESTS.test_landing_page_make")
			report (l_evaluator.execute (agent {LIB_TESTS}.test_landing_page_to_html), "LIB_TESTS.test_landing_page_to_html")
			report (l_evaluator.execute (agent {LIB_TESTS}.test_database_make), "LIB_TESTS.test_database_make")
		end

feature {NONE} -- Implementation

	report (a_result: EQA_PARTIAL_RESULT; a_name: STRING)
			-- Count and print `a_result' of test `a_name'.
		do
			if a_result.is_pass then
				print ("  PASS: " + a_name + "%N")
				passed := passed + 1
			else
				print ("  FAIL: " + a_name + " [" + {UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_result.tag) + "]%N")
				failed := failed + 1
			end
		end

end
