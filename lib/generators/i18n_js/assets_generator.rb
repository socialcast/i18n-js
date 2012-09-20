module I18nJs
  class AssetsGenerator < ::Rails::Generators::Base
    source_root File.expand_path("../../../../vendor/assets/javascripts/i18n", __FILE__)

    def create_assets
      Rails.application.config.i18n.available_locales.each do |locale|
        copy_file 'translations.js.erb', "vendor/assets/javascripts/i18n/translation-#{locale}.js.erb"
      end
    end
  end
end
