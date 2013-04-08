require File.expand_path('../support/schema.rb', __FILE__)
require File.expand_path('../support/models.rb', __FILE__)

require 'database_cleaner'
require 'savant'

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

end
