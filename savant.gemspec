# -*- encoding: utf-8 -*-
require File.expand_path('../lib/savant/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Lind", "Thomas Mayfield"]
  gem.email         = ["info@terriblelabs.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "savant"
  gem.require_paths = ["lib"]
  gem.version       = Savant::VERSION

  gem.add_dependency 'rails'
  gem.add_dependency 'activerecord-tableless', '>= 1.1.3'
  gem.add_dependency 'squeel'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'sqlite3'
end
