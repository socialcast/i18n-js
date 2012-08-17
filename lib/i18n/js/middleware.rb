require 'fileutils'

module I18n
  module JS
    class Middleware
      def initialize(app)
        @app = app
      end

      def call(env)
        @cache = nil
        verify_locale_files!
        @app.call(env)
      end

      private
      def cache_path
        @cache_path ||= Rails.root.join("tmp/cache/i18n-js.yml")
      end

      def cache
        @cache ||= begin
          if cache_path.exist?
            YAML.load_file(cache_path) || {}
          else
            {}
          end
        end
      end

      # Check if translations should be regenerated.
      # ONLY REGENERATE when these conditions are met:
      #
      # # Cache file doesn't exist
      # # Translations and cache size are different (files were removed/added)
      # # Translation file has been updated
      #
      def verify_locale_files!
        valid_cache = []
        new_cache = {}

        valid_cache.push cache_path.exist?
        valid_cache.push ::I18n.load_path.uniq.size == cache.size

        ::I18n.load_path.each do |path|
          changed_at = File.mtime(path).to_i
          valid_cache.push changed_at == cache[path]
          new_cache[path] = changed_at
        end

        return if valid_cache.all?

        File.open(cache_path, "w+") do |file|
          file << new_cache.to_yaml
        end

        self.class.config_per_translation do |filename, translation_scope|
          self.class.save(filename, I18n::Js::Translator.new(translation_scope))
        end
      end
      def self.save(file, translator)
        FileUtils.mkdir_p File.dirname(file)

        files_to_save = if file =~ ::I18n::INTERPOLATION_PATTERN
          ::I18n.available_locales.map do |locale|
            {
              :file => ::I18n.interpolate(file, {:locale => locale}),
              :translations => translator.translations[locale]
            }
          end
        else
          [{
            :file => file,
            :translations => translator.translations
          }]
        end

        files_to_save.each do |file_to_save|
          File.open(file_to_save[:file], "w+") do |f|
            f << %(I18n.translations = );
            f << file_to_save[:translations].to_json
            f << %(;)
          end
        end
      end
      def self.config_file
        "config/i18n-js.yml"
      end
      def self.config
        @@config ||= if config?
          (YAML.load_file(config_file) || {}).with_indifferent_access
        else
          {"public/javascripts/translations.js" => "*"}
        end
      end
      def self.config?
        File.file?(config_file)
      end
      def self.config_per_translation
        config.each_pair do |filename, translation_scope|
          yield filename, translation_scope
        end
      end
    end
  end
end
