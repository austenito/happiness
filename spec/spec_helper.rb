# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'vcr'
require 'pry'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

Capybara.javascript_driver = :webkit

include Warden::Test::Helpers
Warden.test_mode!

RSpec.configure do |c|
  c.mock_with :rspec

  c.around(:each, :vcr) do |example|
    name = example.metadata[:full_description].split(/\s+/, 2).join("/").underscore.gsub(/[^\w\/]+/, "_")
    options = {}
    options[:record] = example.metadata[:record] if example.metadata[:record]
    VCR.use_cassette(name, options) { example.call }
  end

  c.use_transactional_fixtures = true
  c.order = "random"
  c.include FactoryGirl::Syntax::Methods
end

VCR.configure do |c|
  c.cassette_library_dir        = 'spec/vcr'
  c.hook_into                   :webmock

  c.default_cassette_options    = {
    :record                     => :once,
    :decode_compressed_response => true,
    # Because psych is binary encoding response headers marked with ASCII-8BIT
    # https://groups.google.com/forum/?fromgroups#!topic/vcr-ruby/2sKrJa86ktU
    # And syck's output is much easier to read
    :serialize_with             => :psych,
  }

  # Pretty print your json so it's not all on one line
  # From discussion here: https://github.com/myronmarston/vcr/pull/147
  # https://gist.github.com/26edfe7669cc7b85e164
  c.before_record do |i|
    type = Array(i.response.headers['Content-Type']).join(',').split(';').first
    code = i.response.status.code

    if type =~ /[\/+]json$/ or 'text/javascript' == type
      begin
        data = JSON.parse i.response.body
      rescue
        if code != 404
          puts
          warn "VCR: JSON parse error for Content-type #{type}"
          warn "Your unparseable json is: " + i.response.body.inspect
          puts
        end
      else
        i.response.body = JSON.pretty_generate data
        i.response.update_content_length_header
      end
    end
  end
end

Poptart.api_token = 'testing'
