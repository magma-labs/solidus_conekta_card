# encoding: UTF-8

$:.push File.expand_path('../lib', __FILE__)

require 'solidus_conekta_card/version'

Gem::Specification.new do |s|
  s.name        = 'solidus_conekta_card'
  s.version     = SolidusConektaCard::VERSION
  s.summary     = 'Solidus extension for Conekta'
  s.description = 'Solidus extension for processing credit card payments using Conekta API'
  s.license     = 'BSD-3-Clause'

  s.author    = 'Magmalabs'
  s.email     = 'developers@magmalabs.com'
  s.homepage  = 'https://www.magmalabs.io'

  s.files = Dir["{app,config,db,lib}/**/*", 'LICENSE', 'Rakefile', 'README.md']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'solidus', ['>= 2.0', '< 3']
  s.add_dependency 'solidus_support'
  s.add_dependency 'deface'
  s.add_dependency 'conekta'

  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'coffee-rails'
  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'factory_bot'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rubocop', '>= 0.49.0'
  s.add_development_dependency 'rubocop-rspec', '1.4.0'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'sqlite3', '~> 1.3.6'
end
