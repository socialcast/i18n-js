require 'i18n/js/engine'

module I18n
  module Js
    autoload :Translator, "i18n/js/translator"
    autoload :StaticAssetRenderer, "i18n/js/static_asset_renderer"

    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/i18n-js.rake"
      end
      initializer "i18n-js.register_preprocessor", after: :engines_blank_point, before: :finisher_hook do
        Rails.application.config.assets.configure do |config|
          config.register_preprocessor("application/javascript", :"i18n-js_dependencies") do |context, source|
            if context.logical_path == "i18n/filtered"
              ::I18n.load_path.each {|path| context.depend_on(File.expand_path(path))}
            end
            source
          end
        end
      end
    end
  end
end
