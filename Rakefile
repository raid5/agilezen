require "bundler"
Bundler.setup

require "rspec/core/rake_task"
Rspec::Core::RakeTask.new(:spec)

gemspec = eval(File.read("agilezen.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["agilezen.gemspec"] do
  system "gem build agilezen.gemspec"
  system "gem install agilezen-#{AgileZen::VERSION}.gem"
end