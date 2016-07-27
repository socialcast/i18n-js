require "spec_helper"
require 'i18n/js/file_dependency_processor'

describe I18n::Js::FileDependencyProcessor do
  describe '.call' do
    subject(:process_dependencies) { dependency_processor.call(input) }
    let(:dependency_processor) { I18n::Js::FileDependencyProcessor }
    let(:context_class) do
      Class.new do
        def initialize(input); end
        def depend_on(path); end
      end
    end
    before { stub_const('ContextClass', context_class) }
    let(:environment) { double('environment', :context_class => context_class) }
    context 'when the path matches the asset_path_regexp' do
      let(:input) do
        {
          :filename => 'i18n/translation-en.js',
          :source => double('source'),
          :environment => environment
        }
      end
      it 'sets dependencies on the I18n load_paths and the I18n::Js config file' do
        allow(::I18n).to receive(:load_path).and_return(['/path/to/en.yml', '/path/to/es.yml'])
        allow(I18n::Js).to receive(:config_path).and_return('/path/to/i18n/js/config.yml')
        expect_any_instance_of(ContextClass).to receive(:depend_on).with('/path/to/en.yml')
        expect_any_instance_of(ContextClass).to receive(:depend_on).with('/path/to/es.yml')
        expect_any_instance_of(ContextClass).to receive(:depend_on).with('/path/to/i18n/js/config.yml')
        process_dependencies
      end
    end
    context 'when the path does not match the asset_path_regexp' do
      let(:input) do
        {
          :filename => 'not_i18n_translation.js',
          :source => double('source'),
          :environment => environment
        }
      end
      it 'does not set additional dependencies' do
        allow(::I18n).to receive(:load_path).and_return(['/path/to/en.yml', '/path/to/es.yml'])
        allow(I18n::Js).to receive(:config_path).and_return('/path/to/i18n/js/config.yml')
        expect_any_instance_of(ContextClass).to_not receive(:depend_on)
        process_dependencies
      end
    end
  end

  describe ".asset_path_regexp" do
    it "returns a regex of asset_path" do
      expect(I18n::Js::FileDependencyProcessor.asset_path_regexp).to eq %r{i18n/translation}
    end
  end
end
