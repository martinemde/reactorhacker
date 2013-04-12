require 'rubygems'
require 'rake'
require 'pathname'
require 'yaml'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w[--color]
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

namespace :assets do
  task :precompile do
    puts "Compile all the assets!"
    assets = Pathname.new(__FILE__).dirname.join('public','assets')
    assets.mkpath
    asset_name = "myasset-#{Time.now.to_i}.css"
    assets.join('myasset.css').open('w') { |fd| fd << Time.now }
    assets.join('myasset.css.gz').open('w') { |fd| fd << Time.now }
    assets.join("#{asset_name}").open('w') { |fd| fd << Time.now }
    assets.join("#{asset_name}.gz").open('w') { |fd| fd << Time.now }
    assets.join('manifest.yml').open('w') { |fd| YAML.dump({'myasset.css' => asset_name, 'myasset.css.gz' => "#{asset_name}.gz"}, fd) }
  end
end
