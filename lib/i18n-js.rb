require 'active_support/core_ext/hash'

require 'i18n'
require 'i18n/js/railtie'

module I18n
  module Js
    def self.config_path
      Rails.root.join("config", "i18n-js.yml")
    end
    def self.config
      @@config ||= if File.exists?(config_path)
        YAML.load_file(config_path).with_indifferent_access
      else
        {}.with_indifferent_access
      end.reverse_merge!(:asset_path => "i18n/translation", :only => "*")
    end
  end
end
