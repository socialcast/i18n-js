require 'i18n/js/engine'

module I18n
  module Js
    autoload :Translator, "i18n/js/translator"
    autoload :FileDependencyProcessor, "i18n/js/file_dependency_processor"

    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/i18n-js.rake"
      end
      initializer "i18n-js.assetpipeline.environment", :after => "sprockets.environment" do |app|
        app.assets.register_preprocessor("application/javascript", FileDependencyProcessor) if app.config.assets.enabled
      end
    end
  end
end