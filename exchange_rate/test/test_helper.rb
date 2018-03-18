ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/spec'

class ActiveSupport::TestCase
  fixtures :all
end

alias context describe

module Minitest
  module Assertions
    def assert_valid(attribute, model)
      assert_empty model.tap(&:valid?).errors[attribute]
    end

    def assert_not_valid(attribute, model)
      refute_empty model.tap(&:valid?).errors[attribute]
    end
  end

  module Expectations
    infect_an_assertion :assert_valid, :must_be_valid
    infect_an_assertion :assert_not_valid, :wont_be_valid
  end
end
