module I18n
  module JS
    class Translator
      attr_accessor :scopes, :translations
      def initialize(scopes)
        @scopes = scopes
        @translations = segment_for_scope(@scopes)
      end

      def self.filtered_translations
        {}.tap do |result|
          translation_segments.each do |filename, translations|
            if block_given?
              yield(filename, translations)
            else
              deep_merge!(result, translations)
            end
          end
        end
      end

      def self.segment_for_scope(scope)
        if scope == "*"
          translations
        else
          scoped_translations(scope)
        end
      end

      def self.scoped_translations(scopes) # :nodoc:
        result = {}

        [scopes].flatten.each do |scope|
          deep_merge! result, filter(translations, scope)
        end

        result
      end

      # Filter translations according to the specified scope.
      def self.filter(translations, scopes)
        scopes = scopes.split(".") if scopes.is_a?(String)
        scopes = scopes.clone
        scope = scopes.shift

        if scope == "*"
          results = {}
          translations.each do |scope, translations|
            tmp = scopes.empty? ? translations : filter(translations, scopes)
            results[scope.to_sym] = tmp unless tmp.nil?
          end
          return results
        elsif translations.has_key?(scope.to_sym)
          return {scope.to_sym => scopes.empty? ? translations[scope.to_sym] : filter(translations[scope.to_sym], scopes)}
        end
        nil
      end

      # Initialize and return translations
      def self.translations
        ::I18n.backend.instance_eval do
          init_translations unless initialized?
          translations
        end
      end
    end
  end
end
