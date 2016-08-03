require 'i18n/js/engine'

module I18n
  module Js
    autoload :Translator, "i18n/js/translator"
    autoload :StaticAssetRenderer, "i18n/js/static_asset_renderer"

    class Railtie < ::Rails::Railtie
      rake_tasks do
        load "tasks/i18n-js.rake"
      end
    end
  end
end
