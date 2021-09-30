require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "standard/rake"
require "yard"

RSpec::Core::RakeTask.new(:spec)

YARD::Rake::YardocTask.new do |t|
  t.files = ["lib/**/*.rb"]
end

task default: [:spec, :standard]
