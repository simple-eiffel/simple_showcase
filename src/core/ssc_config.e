note
	description: "[
		Configuration loader for Simple Showcase.

		Reads settings from a JSON config file, supporting different
		configurations for development vs production environments.

		Usage:
			config: SSC_CONFIG
			create config.make ("config.json")
			server.make (config.port)
	]"
	author: "Larry Rix with Claude (Anthropic)"
	date: "$Date$"
	revision: "$Revision$"

class
	SSC_CONFIG

inherit
	SSC_LOGGER

create
	make,
	make_default

feature {NONE} -- Initialization

	make (a_config_path: STRING)
			-- Load configuration from JSON file at `a_config_path`
		require
			path_not_empty: not a_config_path.is_empty
		local
			l_json: SIMPLE_JSON
			l_value: detachable SIMPLE_JSON_VALUE
		do
			config_path := a_config_path

			create l_json
			l_value := l_json.parse_file (a_config_path)

			if attached l_value as l_val and then l_val.is_object then
				load_from_json (l_val.as_object)
				is_loaded := True
				log_info ("config", "Loaded configuration from " + a_config_path)
			elseif l_json.has_errors then
				log_info ("config", "JSON parse error in " + a_config_path + ", using defaults")
				set_defaults
			else
				log_info ("config", "Config file not found or invalid: " + a_config_path + ", using defaults")
				set_defaults
			end
		ensure
			path_set: config_path.same_string (a_config_path)
		end

	make_default
			-- Create with default development settings
		do
			config_path := "config.json"
			set_defaults
			log_info ("config", "Using default development configuration")
		end

feature -- Access

	config_path: STRING
			-- Path to the configuration file

	is_loaded: BOOLEAN
			-- Was configuration successfully loaded from file?

	mode: STRING
			-- Running mode: "development" or "production"

	port: INTEGER
			-- HTTP server port

	base_url: STRING
			-- Base URL for the site (used in generated links)

	contact_email: STRING
			-- Email address for contact form submissions

	db_path: STRING
			-- Path to SQLite database file

	log_level: STRING
			-- Logging level: "debug", "info", "warn", "error"

	verbose_logging: BOOLEAN
			-- Enable verbose console output?

feature -- Status

	is_development: BOOLEAN
			-- Are we running in development mode?
		do
			Result := mode.same_string ("development")
		end

	is_production: BOOLEAN
			-- Are we running in production mode?
		do
			Result := mode.same_string ("production")
		end

feature {NONE} -- Implementation

	set_defaults
			-- Set default development values
		do
			mode := "development"
			port := 8080
			base_url := "http://localhost:8080"
			contact_email := ""
			db_path := "showcase_dev.db"
			log_level := "debug"
			verbose_logging := True
			is_loaded := False
		ensure
			development_mode: is_development
			default_port: port = 8080
		end

	load_from_json (a_obj: SIMPLE_JSON_OBJECT)
			-- Load settings from parsed JSON object
		do
			-- Mode
			if attached a_obj.item ("mode") as l_mode and then l_mode.is_string then
				mode := l_mode.as_string_32.to_string_8
			else
				mode := "development"
			end

			-- Port
			if attached a_obj.item ("port") as l_port and then l_port.is_number then
				port := l_port.as_integer.to_integer_32
			else
				port := 8080
			end

			-- Base URL
			if attached a_obj.item ("base_url") as l_url and then l_url.is_string then
				base_url := l_url.as_string_32.to_string_8
			else
				base_url := "http://localhost:" + port.out
			end

			-- Contact email
			if attached a_obj.item ("contact_email") as l_email and then l_email.is_string then
				contact_email := l_email.as_string_32.to_string_8
			else
				contact_email := ""
			end

			-- Database path
			if attached a_obj.item ("db_path") as l_db and then l_db.is_string then
				db_path := l_db.as_string_32.to_string_8
			else
				db_path := "showcase.db"
			end

			-- Log level
			if attached a_obj.item ("log_level") as l_log and then l_log.is_string then
				log_level := l_log.as_string_32.to_string_8
			else
				log_level := "info"
			end

			-- Verbose logging
			if attached a_obj.item ("verbose_logging") as l_verbose and then l_verbose.is_boolean then
				verbose_logging := l_verbose.as_boolean
			else
				verbose_logging := is_development
			end

			log_debug ("config", "mode=" + mode + ", port=" + port.out + ", base_url=" + base_url)
		end

invariant
	mode_not_empty: not mode.is_empty
	port_positive: port > 0
	base_url_not_empty: not base_url.is_empty
	db_path_not_empty: not db_path.is_empty
	log_level_not_empty: not log_level.is_empty

end
