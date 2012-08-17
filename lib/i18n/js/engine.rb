require "i18n/js"

module I18n
  module JS
    class Engine < ::Rails::Engine
      initializer :after => "sprockets.environment" do |app|
        ActiveSupport.on_load(:after_initialize, :yield => true) do
          config = app.config
          asset_path = config.i18n_js.asset_path || 'i18n/translation'
          next unless config.assets.enabled

          app.assets.register_preprocessor "application/javascript", :"i18n-js_dependencies" do |context, source|
            next source unless context.logical_path =~ %r{#{asset_path}}
            ::I18n.load_path.each {|path| context.depend_on(path)}
            source
          end
        end
      end
    end
  end
end
