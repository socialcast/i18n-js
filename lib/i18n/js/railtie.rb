require 'i18n/js/engine'

module I18n
  module Js
    autoload :Translator, "i18n/js/translator"
    autoload :FileDependencyProcessor, "i18n/js/file_dependency_processor"
    autoload :StaticAssetRenderer, "i18n/js/static_asset_renderer"

    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/i18n-js.rake"
      end
      initializer "i18n-js.assetpipeline.environment", :after => "sprockets.environment" do |app|
        next unless app.config.assets.enabled
        app.config.assets.configure do |config|
          config.register_preprocessor("application/javascript", :"i18n-js_dependencies") do |context, source|
            FileDependencyProcessor.evaluate(context, source)
          end
        end
      end
    end
  end
end
