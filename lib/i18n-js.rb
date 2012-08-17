require 'ext/hash' unless %w{deep_merge, :deep_merge!}.all? {|method| Hash.method_defined?(method.to_sym) }

require 'i18n'
require 'i18n/js/railtie'

module I18n
  module Js
  end
end
