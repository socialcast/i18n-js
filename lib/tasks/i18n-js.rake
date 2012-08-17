namespace :i18n do
  namespace :js do
    namespace :export do
      task :assets => [:environment] do
        Dir.glob(Rails.application.config.i18n_js.asset_path + "*") do |asset_path|
          File.open(Rails.root.join('public', 'assets', asset_path.split(/\./)[0..1].join('.')), 'w') do |file|
            file.write(Rails.application.assets[asset_path].to_a.map { |asset| asset.body }.join("\n"))
          end
        end
      end
    end
  end
end
