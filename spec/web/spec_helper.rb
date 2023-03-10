# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'
require_relative '../warnings_helper'
require_relative '../../app'
raise "test database doesn't end with test" unless DB.opts[:database] =~ /test\z/

require 'capybara'
require 'capybara/dsl'
require 'rack/test'

Gem.suffix_pattern

require_relative '../minitest_helper'

begin
  require 'refrigerator'
rescue LoadError
else
  Refrigerator.freeze_core
end

PersonalSite.plugin :not_found do
  raise '404 - File Not Found'
end
PersonalSite.plugin :error_handler do |e|
  raise e
end

Capybara.app = PersonalSite.freeze.app

module Minitest
  class HooksSpec
    include Rack::Test::Methods
    include Capybara::DSL

    def app
      Capybara.app
    end

    after do
      Capybara.reset_sessions!
      Capybara.use_default_driver
    end
  end
end
