# frozen_string_literal: true

$:.push File.expand_path('lib', __dir__)

require 'repo-compare/version'

Gem::Specification.new do |spec|
  spec.name        = 'repo-compare'
  spec.version     = RepoCompare::VERSION
  spec.authors     = ['Mattia Roccoberton']
  spec.email       = ['mat@blocknot.es']
  spec.homepage    = 'https://github.com/blocknotes/repo-compare'
  spec.summary     = 'Repo Compare'
  spec.description = 'Track changes of another repo.'
  spec.license     = 'MIT'

  spec.files = Dir['{bin,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']
  spec.executables << 'repo-compare'
end
