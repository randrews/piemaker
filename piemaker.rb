require "rubygems"
require "activesupport" # For the base extensions, we'll drop this later

module SVM ; end

Dir[File.join(File.dirname(__FILE__), "lib/**/*.rb")].each{|f| require f}
