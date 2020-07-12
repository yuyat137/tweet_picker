Rails.application.config.sorcery.submodules = [:external]

Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:twitter]

  config.twitter.key = Rails.application.credentials.dig(:twitter, :api_key)
  config.twitter.secret = Rails.application.credentials.dig(:twitter, :api_secret_key)
  config.twitter.callback_url = Rails.configuration.environment_value['twitter_callback_url']
  config.twitter.user_info_mapping = { email: 'screen_name' }

  config.user_config do |user|
    user.stretches = 1 if Rails.env.test?
    user.authentications_class = Authentication
  end
  config.user_class = 'User'
end
