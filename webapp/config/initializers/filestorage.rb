def load_config(key, filepath)
  yml = YAML.load_file filepath
  abort "No such file #{filepath}" unless yml

  config = yml[Rails.env]
  abort "No such environment #{Rails.env} on #{filepath}" unless config

  Rails.application.config.send(
    "#{key}=".to_sym,
    ActiveSupport::InheritableOptions.new(config.deep_symbolize_keys)
    )
end

load_config :filestorage, Rails.root.join('config', 'filestorage.yml')


require 'filestorage/client'
