module I18n
  module Js
    class Translator
      attr_accessor :scopes, :translations
      def initialize(scopes)
        @scopes = scopes
        @translations = self.class.deep_hash_key_sort(self.class.segment_for_scope(@scopes))
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
          result.deep_merge!(filter(translations, scope))
        end

        result
      end

      # Filter translations according to the specified scope.
      def self.filter(filter_translations, scopes)
        scopes = scopes.split(".") if scopes.is_a?(String)
        scopes = scopes.clone
        scope = scopes.shift

        if scope == "*"
          results = {}
          filter_translations.each do |filter_scope, filter_translation|
            tmp = scopes.empty? ? filter_translation : filter(filter_translation, scopes)
            results[filter_scope.to_sym] = tmp unless tmp.nil?
          end
          return results
        elsif filter_translations.has_key?(scope.to_sym)
          return {scope.to_sym => scopes.empty? ? filter_translations[scope.to_sym] : filter(filter_translations[scope.to_sym], scopes)}
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

      protected

      def self.deep_hash_key_sort hash
        ret = hash.inject({}) do |h, (k, v)|
          h[k] = v.is_a?(Hash) ? deep_hash_key_sort(v) :  v
          h
        end
        Hash[ret.sort]
      end
    end
  end
end
