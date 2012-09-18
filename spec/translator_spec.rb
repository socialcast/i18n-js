require "spec_helper"
require 'i18n/js/translator'

describe I18n::Js::Translator do
  context "#filter" do
    it "filters translations using scope *.date.formats" do
      result = I18n::Js::Translator.filter(translations, "*.date.formats")
      result[:en][:date].keys.should eql([:formats])
      result[:fr][:date].keys.should eql([:formats])
    end
  end
  context "#scoped_translations" do
    it "filters translations using scope [*.date.formats, *.number.currency.format]" do
      result = I18n::Js::Translator.scoped_translations(["*.date.formats", "*.number.currency.format"])
      result[:en].keys.collect(&:to_s).sort.should eql(%w[ date number ])
      result[:fr].keys.collect(&:to_s).sort.should eql(%w[ date number ])
    end

    it "filters translations using multi-star scope" do
      result = I18n::Js::Translator.scoped_translations("*.*.formats")

      result[:en].keys.collect(&:to_s).sort.should eql(%w[ date time ])
      result[:fr].keys.collect(&:to_s).sort.should eql(%w[ date time ])

      result[:en][:date].keys.should eql([:formats])
      result[:en][:time].keys.should eql([:formats])

      result[:fr][:date].keys.should eql([:formats])
      result[:fr][:time].keys.should eql([:formats])
    end

    it "filters translations using alternated stars" do
      result = I18n::Js::Translator.scoped_translations("*.admin.*.title")

      result[:en][:admin].keys.collect(&:to_s).sort.should eql(%w[ edit show ])
      result[:fr][:admin].keys.collect(&:to_s).sort.should eql(%w[ edit show ])

      result[:en][:admin][:show][:title].should eql("Show")
      result[:fr][:admin][:show][:title].should eql("Visualiser")

      result[:en][:admin][:edit][:title].should eql("Edit")
      result[:fr][:admin][:edit][:title].should eql("Editer")
    end
  end
end
