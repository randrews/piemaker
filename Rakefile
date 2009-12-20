require "fileutils"

task :default => :test

task :clean do
  files=Dir["**/*~"]
  puts "Removing #{files.size} Emacs temp file#{(files.size==1 ? '' : 's')}"
  files.each do |tmp|
    FileUtils.rm tmp
  end

  puts "Removing built gem"
  `rm -f svm-*.gem`
end

task :test do
  exec "spec --color test/*.rb"
end

task :gem do
  raise NotImplementedError
  `rm -f svm-*.gem`
  `gem build svm.gemspec`
end

task :install=>:gem do
  `gem install --force svm-*.gem`
end

task :profile do
  require "rubygems"
  require "ruby-prof"
  test_dir=File.join(File.dirname(__FILE__),"test")

  result = RubyProf.profile do
    require File.join(File.dirname(__FILE__),"svm.rb")

    # Monkeypatch Dhaka because it's blowing up on parser.inspect.
    # class Dhaka::CompiledParser ; def self.grammar ; "" ; end ; end

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
