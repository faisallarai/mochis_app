# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'spec_helper'
require 'capybara/rails'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # config.treat_symbols_as_metadata_keys_with_true_values = true
  # config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end