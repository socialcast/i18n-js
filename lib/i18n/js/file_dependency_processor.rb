require 'sprockets'
module I18n
  module Js
    class FileDependencyProcessor
      def self.asset_path_regexp
        @@asset_path_regexp ||= %r{#{I18n::Js.config[:asset_path]}}
      end

      def self.call(input)
        filename = input[:filename]
        source = input[:data]
        return source unless filename =~ asset_path_regexp
        context = input[:environment].context_class.new(input)
        ::I18n.load_path.each { |path| context.depend_on(path) }
        context.depend_on(I18n::Js.config_path)
        source
      end
    end
  end
end
