# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!

# used to have correct host when generating full links
Dyno::Application.default_url_options = Dyno::Application.config.action_mailer.default_url_options
