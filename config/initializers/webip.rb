# Custom configuration
#config_webip = Rails.application.config_for(:webip)
WEBIP = YAML.load_file("config/webip.yml")[Rails.env]
