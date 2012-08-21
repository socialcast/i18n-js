#encoding: utf-8
module I18n
  module Js
    class FileDependencyProcessor < Sprockets::Processor
      def self.asset_path
        @@asset_path ||= I18n::Js.config[:asset_path] || 'i18n/translation'
      end
      def self.asset_path_regexp
        @@asset_path_regexp ||= %r{#{asset_path}}
      end
      def evaluate(context, locals)
        return data unless context.logical_path =~ self.class.asset_path_regexp
        ::I18n.load_path.each {|path| context.depend_on(path)}
        context.depend_on(I18n::Js.config_path)
        data
      end
    end
  end
end