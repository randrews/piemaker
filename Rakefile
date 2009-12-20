require "fileutils"

task :default => :test

task :clean do
  files=Dir["**/*~"]
  puts "Removing #{files.size} Emacs temp file#{(files.size==1 ? '' : 's')}"
  files.each do |tmp|
    FileUtils.rm tmp
  end

  puts "Removing built gem"
  `rm -f piemaker-*.gem`
end

task :test do
  exec "spec --color test/*.rb"
end

task :gem do
  raise NotImplementedError
  `rm -f piemaker-*.gem`
  `gem build piemaker.gemspec`
end

task :install=>:gem do
  raise NotImplementedError
  `gem install --force piemaker-*.gem`
end

task :profile do
  require "rubygems"
  require "ruby-prof"
  test_dir=File.join(File.dirname(__FILE__),"test")

  result = RubyProf.profile do
    require File.join(File.dirname(__FILE__),"piemaker.rb")

    if ENV["TEST"]
      require File.join(test_dir,"#{test}.rb")
    elsif ENV["STARTUP"]
      # nothing, just load jam.rb
    else
      Dir[File.join(test_dir,"*.rb")].each do |test|
        require test
      end
    end
  end

  # Print a graph profile to text
  printer = RubyProf::FlatPrinter.new(result)
  printer.print(STDOUT, 0)
end
