note
	description: "[
		Aggressive logging helper for Simple Showcase debugging.

		Provides timestamped, categorized logging with different severity levels.
		Output goes to both console AND a log file for persistent debugging.

		Log file location: ssc_server.log (in current working directory)

		Usage:
			inherit SSC_LOGGER
			...
			log_info ("section", "Building hero section")
			log_debug ("render", "HTML output: " + html.count.out + " chars")
	]"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_LOGGER

feature -- Logging

	log_info (a_category, a_message: STRING)
			-- Log informational message.
		require
			category_not_empty: not a_category.is_empty
			message_not_empty: not a_message.is_empty
		do
			log_message ("INFO", a_category, a_message)
		end

	log_debug (a_category, a_message: STRING)
			-- Log debug message (verbose).
		require
			category_not_empty: not a_category.is_empty
			message_not_empty: not a_message.is_empty
		do
			if debug_enabled then
				log_message ("DEBUG", a_category, a_message)
			end
		end

	log_warn (a_category, a_message: STRING)
			-- Log warning message.
		require
			category_not_empty: not a_category.is_empty
			message_not_empty: not a_message.is_empty
		do
			log_message ("WARN", a_category, a_message)
		end

	log_error (a_category, a_message: STRING)
			-- Log error message.
		require
			category_not_empty: not a_category.is_empty
			message_not_empty: not a_message.is_empty
		do
			log_message ("ERROR", a_category, a_message)
		end

	log_enter (a_feature_name: STRING)
			-- Log entering a feature (for tracing).
		require
			feature_name_not_empty: not a_feature_name.is_empty
		do
			log_message ("TRACE", "enter", ">>> " + a_feature_name)
			increment_indent
		ensure
			indent_increased: indent_level = old indent_level + 1
		end

	log_exit (a_feature_name: STRING)
			-- Log exiting a feature (for tracing).
		require
			feature_name_not_empty: not a_feature_name.is_empty
		do
			decrement_indent
			log_message ("TRACE", "exit", "<<< " + a_feature_name)
		end

	log_html_size (a_context: STRING; a_html: STRING)
			-- Log HTML output size for debugging rendering.
		require
			context_not_empty: not a_context.is_empty
			html_not_void: a_html /= Void
		do
			log_debug ("html", a_context + " generated " + a_html.count.out + " chars")
		end

feature -- Configuration

	debug_enabled: BOOLEAN
			-- Is debug-level logging enabled?
		once
			Result := True  -- Enable by default for aggressive logging
		end

	log_file_name: STRING = "ssc_server.log"
			-- Name of the log file.

feature {NONE} -- Implementation

	log_message (a_level, a_category, a_message: STRING)
			-- Output formatted log message to console (minimal) and file (full).
		local
			l_output: STRING
			l_time: TIME
			i: INTEGER
			l_is_important: BOOLEAN
		do
			create l_output.make (200)

			-- Timestamp
			create l_time.make_now
			l_output.append ("[")
			l_output.append (format_time (l_time))
			l_output.append ("] ")

			-- Sequence number for ordering
			l_output.append ("[")
			l_output.append (log_sequence.out)
			l_output.append ("] ")
			increment_sequence

			-- Level with fixed width
			l_output.append ("[")
			l_output.append (padded_level (a_level))
			l_output.append ("] ")

			-- Category with fixed width
			l_output.append ("[")
			l_output.append (padded_category (a_category))
			l_output.append ("] ")

			-- Indent for enter/exit tracing
			from i := 1 until i > indent_level loop
				l_output.append ("  ")
				i := i + 1
			end

			-- Message
			l_output.append (a_message)

			-- Only INFO, WARN, ERROR go to console (minimal output)
			l_is_important := a_level.same_string ("INFO") or a_level.same_string ("WARN") or a_level.same_string ("ERROR")
			if l_is_important then
				print (l_output)
				print ("%N")
				io.output.flush
			end

			-- Everything goes to file (full output)
			write_to_file (l_output)
		end

	write_to_file (a_message: STRING)
			-- Append message to log file.
		local
			l_file: PLAIN_TEXT_FILE
		do
			create l_file.make_open_append (log_file_name)
			if l_file.is_open_write then
				l_file.put_string (a_message)
				l_file.put_new_line
				l_file.flush
				l_file.close
			end
		rescue
			-- Ignore file errors, continue logging to console
			if l_file /= Void and then l_file.is_open_write then
				l_file.close
			end
		end

	format_time (a_time: TIME): STRING
			-- Format time as HH:MM:SS.mmm
		require
			time_not_void: a_time /= Void
		do
			create Result.make (12)
			if a_time.hour < 10 then Result.append ("0") end
			Result.append (a_time.hour.out)
			Result.append (":")
			if a_time.minute < 10 then Result.append ("0") end
			Result.append (a_time.minute.out)
			Result.append (":")
			if a_time.second < 10 then Result.append ("0") end
			Result.append (a_time.second.out)
			Result.append (".")
			-- Milliseconds from fractional seconds
			Result.append (((a_time.fractional_second * 1000).truncated_to_integer \\ 1000).out)
		ensure
			not_empty: not Result.is_empty
			has_colons: Result.has (':')
		end

	padded_level (a_level: STRING): STRING
			-- Pad level to 5 characters.
		require
			level_not_empty: not a_level.is_empty
		do
			create Result.make (5)
			Result.append (a_level)
			from until Result.count >= 5 loop
				Result.append (" ")
			end
		ensure
			at_least_five: Result.count >= 5
			contains_level: Result.has_substring (a_level)
		end

	padded_category (a_category: STRING): STRING
			-- Pad category to 8 characters.
		require
			category_not_empty: not a_category.is_empty
		do
			create Result.make (8)
			Result.append (a_category)
			from until Result.count >= 8 loop
				Result.append (" ")
			end
		ensure
			at_least_eight: Result.count >= 8
			contains_category: Result.has_substring (a_category)
		end

	log_sequence: INTEGER_REF
			-- Sequence counter for log messages.
		once
			create Result
			Result.set_item (1)
		end

	increment_sequence
			-- Increment sequence counter.
		do
			log_sequence.set_item (log_sequence.item + 1)
		end

	indent_level_cell: INTEGER_REF
			-- Cell for indent level.
		once
			create Result
			Result.set_item (0)
		end

	indent_level: INTEGER
			-- Current indent level.
		do
			Result := indent_level_cell.item
		ensure
			non_negative: Result >= 0
		end

	increment_indent
			-- Increase indent level.
		do
			indent_level_cell.set_item (indent_level_cell.item + 1)
		end

	decrement_indent
			-- Decrease indent level.
		do
			if indent_level_cell.item > 0 then
				indent_level_cell.set_item (indent_level_cell.item - 1)
			end
		ensure
			non_negative: indent_level >= 0
		end

end
