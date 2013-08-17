require 'localeapp/rails'

Localeapp.configure do |config|
  config.api_key = Configuration[:localeapp_key]
end
