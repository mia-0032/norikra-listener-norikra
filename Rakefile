require "bundler/gem_tasks"

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.rspec_opts = ["-Ijar", "-Ilib", "-c", "-f progress"] # '--format specdoc'
  t.pattern = 'spec/*_spec.rb'
end

task :default => :spec
