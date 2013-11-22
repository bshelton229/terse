require 'yaml'

config_file = Rails.root.join('config/config.yml')

if File.exist? config_file
  if ( yaml = YAML.load File.read(config_file) )
    config = {}
    # Merge in environment specific variables
    config.merge! yaml.merge!(yaml.fetch(Rails.env, {}))
    config.each do |k,value|
      key = k.to_s.upcase
      ENV[key] = value if key && value.kind_of?(String)
    end
  end
end
