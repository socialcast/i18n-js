module I18n
  module Js
    autoload :Translator, "i18n/js/translator"

    class Railtie < ::Rails::Railtie
      rake_tasks do
        rake "tasks/i18n-js.rake"
      end

      initializer "i18n-js.environment" do |app|
        config = app.config
        if !config.i18n_js.disabled && config.assets.enabled
          require "i18n/js/engine"
        else
          require "i18n/js/middleware"
        end
      end
    end
  end
end
