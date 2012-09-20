module I18n
  module Js
    class StaticAssetRenderer
      def self.json_for_locale(current_locale)
        translations = I18n::Js::Translator.new(I18n::Js.config[:only]).translations
        default_locale = Rails.application.config.i18n.default_locale
        scoped_translation = translations.select { |locale, value| [nil, locale.to_s].include?(current_locale) }
        scoped_translation = { current_locale.to_sym => translations[default_locale.to_sym].deep_merge(scoped_translation[current_locale.to_sym])} unless current_locale.nil? || current_locale == default_locale
        scoped_translation.to_json
      end
      def self.extract_locale_from_filename(filename)
        filename[/translation\-(\w*)/, 1]
      end
    end
  end
end
