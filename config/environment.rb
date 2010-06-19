# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

#needs to be placed before initializer b/c routes
STATIC_PAGES = %w(options_tutorial tutorial setup help features)

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )

  # Specify gems that this application depends on and have them installed with rake gems:install
  # config.gem "bj"
  # config.gem "hpricot", :version => '0.6', :source => "http://code.whytheluckystiff.net"
  # config.gem "sqlite3-ruby", :lib => "sqlite3"
  # config.gem "aws-s3", :lib => "aws/s3"
  config.gem "hpricot"
  config.gem "hobofields"
  config.gem "haml"
  config.gem "zeke-monkey_patches", :lib => "monkey_patches", :source => "http://gems.github.com"
  # config.gem "will_paginate"

  # Only load the plugins named here, in the order given (default is alphabetical).
  # :all can be used as a placeholder for all plugins not explicitly named
  # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

  # Skip frameworks you're not going to use. To use Rails without a database,
  # you must remove the Active Record framework.
  # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

  # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
  # Run "rake -D time" for a list of tasks for finding time zone names.
  config.time_zone = 'UTC'

  # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
  # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
  # config.i18n.default_locale = :de
end

Time::DATE_FORMATS[:short] = "%B %d, %l:%M%p"
Time::DATE_FORMATS[:medium] = "%B %d, %Y"
Time::DATE_FORMATS[:blog] = "%A, %B %d at %l:%M%p"
Time::DATE_FORMATS[:long] = "%A, %B %d at %l:%M%p"
Time::DATE_FORMATS[:ymdhms] = Time::DATE_FORMATS[:batch] = "%Y%m%d%H%M%S"

DEFAULT_PARAM = "(q)"
OPTION_NAME_REGEX = '\w+'
#option is a word with a optional metadata delimited by '=' ie [:type=normal]
OPTION_PARAM_REGEX = /\[:(#{OPTION_NAME_REGEX})(=[^\[\]]+)?\]/    

ExceptionNotifier.exception_recipients = %w(zeke@queri.ac gabriel.horner@gmail.com)
ExceptionNotifier.sender_address = %("Application Error" <admin@queri.ac>)
ExceptionNotifier.email_prefix = "[queriac] "

# Include your application configuration below
require 'open-uri'
require 'hpricot'

common_stopwords = %w(user_commands commands tags queries users opensearch)
COMMAND_STOPWORDS = %w(default_to delete search_form search_all execute update tag_set tag_add_remove find_by_ids) + common_stopwords + Command::TYPES.map {|e| e.to_s}
USER_STOPWORDS = %w(home settings) + STATIC_PAGES + common_stopwords
HOST = 'localhost:3000' unless Object.const_defined?('HOST')