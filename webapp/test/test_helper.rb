require 'simplecov'
require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::Codecov
]
SimpleCov.start do
  add_filter "/test/"
  add_filter "/config/"
  add_filter do |source_file|
    source_file.lines.count < 5
  end
end

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Add more helper methods to be used by all tests here...
  #include Devise::TestHelpers
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include Devise::TestHelpers
end
