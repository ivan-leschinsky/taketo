# encoding: utf-8
require 'rubygems'
require 'bundler'
require 'bundler/gem_tasks'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'

require 'rake/clean'
CLOBBER.include('doc/**', 'pkg/**', 'coverage/**')

# require 'rspec/core/rake_task'
# RSpec::Core::RakeTask.new do |t|
#   t.pattern = 'spec/lib/**/*_spec.rb'
# end

# RSpec::Core::RakeTask.new(:integration_spec) do |t|
#   t.pattern = 'spec/integration/**/*_spec.rb'
# end

# RSpec::Core::RakeTask.new(:acceptance_spec) do |t|
#   t.pattern = 'spec/acceptance/**/*_spec.rb'
# end

require 'yard'
YARD::Rake::YardocTask.new

task :localinstall do
  system("rm -f *.gem && gem build taketo.gemspec && gem uninstall --force taketo && gem install ./taketo-*.gem && rvm wrapper ruby-2.4.1 --no-prefix taketo")
end

# task :default => [:spec, :acceptance_spec]
