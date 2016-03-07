require 'sprockets'
module I18n
  module Js
    class FileDependencyProcessor
      def self.asset_path_regexp
        @@asset_path_regexp ||= %r{#{I18n::Js.config[:asset_path]}}
      end

      def self.evaluate(context, source)
        return source unless context.logical_path =~ asset_path_regexp
        ::I18n.load_path.each { |path| context.depend_on(path) }
        context.depend_on(I18n::Js.config_path)
        source
      end
    end
  end
end
