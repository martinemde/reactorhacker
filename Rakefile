require 'rubygems'
require 'rake'
require 'pathname'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new do |t|
  t.rspec_opts = %w[--color]
  t.pattern = 'spec/**/*_spec.rb'
end

task :default => :spec

namespace :assets do
  task :precompile do
    puts "Compile all the assets!"
    Pathname.new(__FILE__).dirname.join('public','assets').mkpath
  end
end
