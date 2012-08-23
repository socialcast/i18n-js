require "spec_helper"

describe I18n::Js do
  context "general" do
    it "sets empty hash as configuration when no file is found" do
      I18n::Js.stub(:config_path => "/path/to/config/config.yml")
      I18n::Js.config?.should be_false
      I18n::Js.config.should eql({"asset_path" => "i18n/translation", "only" => "*"})
    end
  end
end
