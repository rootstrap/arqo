# frozen_string_literal: true

require_relative 'lib/arqo/version'

Gem::Specification.new do |spec|
  spec.name          = 'arqo'
  spec.version       = ARQO::VERSION
  spec.authors       = ['Santiago Bartesaghi']
  spec.email         = ['santib@hey.com']

  spec.summary       = 'Easing the query object pattern in Rails applications.'
  spec.homepage      = 'https://github.com/rootstrap/arqo'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.0')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rootstrap/arqo'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir['LICENSE.txt', 'README.md', 'lib/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'activerecord', ['>= 5.2']

  spec.add_development_dependency 'ammeter', '~> 1.1'
  spec.add_development_dependency 'database_cleaner-active_record', '~> 1.8.0'
  spec.add_development_dependency 'rake', '~> 13.0.1'
  spec.add_development_dependency 'reek', '~> 6.0.6'
  spec.add_development_dependency 'rspec', '~> 3.9.0'
  spec.add_development_dependency 'rubocop', '~> 1.24.1'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
  spec.add_development_dependency 'sqlite3', '~> 1.4.2'
end
