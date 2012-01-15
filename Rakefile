require "bundler/gem_tasks"
require "rake/testtask"

desc "Default: run the unit tests."
task :default => :test

desc "Test the plugin."
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.pattern = "test/**/*_test.rb"
  t.verbose = true
end

desc "Start the testing server."
task :start_server do

  %x[ruby ./test/server.rb]

end
