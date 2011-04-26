RAILS_GEM_VERSION = '2.3.11' unless defined? RAILS_GEM_VERSION
require File.join(File.dirname(__FILE__), 'boot')

#needs to be placed before initializer b/c routes
STATIC_PAGES = %w(options_tutorial tutorial setup help features)

Rails::Initializer.run do |config|
  config.gem "hpricot"
  config.gem "hobofields"
  config.gem "haml"
  config.gem "sass"
  config.gem "wordnik_ruby_helpers"
  config.gem "will_paginate", :version => "2.3.14"
  config.time_zone = 'UTC'
	config.gem 'csv-mapper'
end

Time::DATE_FORMATS[:short] = "%B %d"
Time::DATE_FORMATS[:medium] = "%B %d, %Y"
Time::DATE_FORMATS[:blog] = "%A, %B %d at %l:%M%p"
Time::DATE_FORMATS[:long] = "%A, %B %d at %l:%M%p"
Time::DATE_FORMATS[:ymdhms] = Time::DATE_FORMATS[:batch] = "%Y%m%d%H%M%S"

DEFAULT_PARAM = "(q)"
OPTION_NAME_REGEX = '\w+'
#option is a word with a optional metadata delimited by '=' ie [:type=normal]
OPTION_PARAM_REGEX = /\[:(#{OPTION_NAME_REGEX})(=[^\[\]]+)?\]/

# Include your application configuration below
require 'open-uri'
require 'hpricot'

common_stopwords = %w(user_commands commands tags queries users opensearch)
COMMAND_STOPWORDS = %w(default_to delete search_form search_all execute update tag_set tag_add_remove find_by_ids) + common_stopwords + Command::TYPES.map {|e| e.to_s}
USER_STOPWORDS = %w(home settings) + STATIC_PAGES + common_stopwords
HOST = 'localhost:3000' unless Object.const_defined?('HOST')