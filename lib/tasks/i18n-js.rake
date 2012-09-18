namespace :i18n do
  namespace :js do
    namespace :export do
      task :assets => [:environment] do
        require 'fileutils'
        Dir.glob(Rails.application.assets.paths.map { |path| File.join(path, "#{I18n::Js.config[:asset_path]}*") }) do |asset_path|
          asset = Rails.application.assets[asset_path]
          export_path = Rails.root.join('public', asset.logical_path)
          FileUtils.mkdir_p File.dirname(export_path)
          File.open(export_path, 'w') do |file|
            file.write(asset.to_a.map { |x| x.body }.join("\n"))
          end
        end
      end
    end
  end
end
