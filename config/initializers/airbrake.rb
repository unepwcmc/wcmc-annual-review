Airbrake.configure do |config|
  config.host = 'https://exceptions.codebasehq.com'
  config.project_key = 'f067551b-6213-2473-4bea-63fd4b98a793'
  config.project_id = 209858
  config.environment = Rails.env
  config.ignore_environments = %w(development test)
end