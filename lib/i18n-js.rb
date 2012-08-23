require 'active_support/core_ext/hash'

require 'i18n'
require 'i18n/js/railtie' if defined?(Rails)

module I18n
  module Js
    def self.config_path
      Rails.root.join("config", "i18n-js.yml")
    end
    def self.config?
      File.exists?(config_path)
    end
    def self.config
      @@config ||= if config?
        YAML.load_file(config_path).with_indifferent_access
      else
        {}.with_indifferent_access
      end.reverse_merge!(:asset_path => "i18n/translation", :only => "*")
    end
  end
end
