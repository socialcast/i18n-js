require "spec_helper"
require 'i18n/js/file_dependency_processor'

describe I18n::Js::FileDependencyProcessor do
  context "#evaluate" do
    let(:dependency_processor) { I18n::Js::FileDependencyProcessor.new { @js } }
    it "sets dependencies on the I18n load_paths and the I18n::Js config file" do
      ::I18n.stub(:load_path => ["/path/to/en.yml", "/path/to/es.yml"])
      I18n::Js.stub(:config_path => "/path/to/i18n/js/config.yml")
      context = double("context")
      context.should_receive(:logical_path).and_return("i18n/translation-en.js")
      context.should_receive(:depend_on).with("/path/to/en.yml")
      context.should_receive(:depend_on).with("/path/to/es.yml")
      context.should_receive(:depend_on).with("/path/to/i18n/js/config.yml")
      locals = double("locals")
      dependency_processor.evaluate(context, locals)
    end
    it "skips setting dependencies when the logical path doesn't match the asset_path_regexp" do
      I18n::Js.stub(:config_path => "/path/to/i18n/js/config.yml")
      context = double("context")
      context.should_receive(:logical_path).and_return("not_i18n_translation.js")
      context.should_not_receive(:depend_on)
      locals = double("locals")
      dependency_processor.evaluate(context, locals)
    end
  end
  context "#asset_path_regexp" do
    it "returns a regex of asset_path" do
      I18n::Js::FileDependencyProcessor.asset_path_regexp.should eql(%r{i18n/translation})
    end
  end
end
