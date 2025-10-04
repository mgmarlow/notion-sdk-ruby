require "bundler/gem_tasks"
require "standard/rake"
require "steep/rake_task"

Steep::RakeTask.new do |t|
  t.check.severity_level = :error
end

task default: [:standard, :steep]
