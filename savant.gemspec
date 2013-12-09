# -*- encoding: utf-8 -*-
require File.expand_path('../lib/savant/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Lind", "Thomas Mayfield"]
  gem.email         = ["info@terriblelabs.com"]
  gem.description   = %q{ Savant extends ActiveRecord by allowing you to easily
                          create queries and reports for your application's models
                          by defining aggregate models in terms of dimensions
                          and measures. }
  gem.summary       = %q{ Savant: objective aggregate queries and reporting for ActiveRecord. }
  gem.homepage      = "http://github.com/terribelabs/savant"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "savant"
  gem.require_paths = ["lib"]
  gem.version       = Savant::VERSION

  gem.add_dependency 'rails', '~> 3.2'
  gem.add_dependency 'activerecord-tableless', '~> 1.1.3'
  gem.add_dependency 'squeel'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'debugger'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'rb-fsevent'

end
