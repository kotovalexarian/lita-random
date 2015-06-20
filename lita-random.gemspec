# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lita/random/version'

Gem::Specification.new do |spec|
  spec.name          = 'lita-random'
  spec.version       = Lita::Random::VERSION
  spec.authors       = ['Braiden Vasco']
  spec.email         = ['braiden-vasco@mailtor.net']

  spec.summary =
    'Generator of random numbers and strings for the Lita chat bot'
  spec.description =
    'Generator of random numbers and strings for the Lita chat bot.'
  spec.homepage      = 'https://github.com/braiden-vasco/lita-random'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
