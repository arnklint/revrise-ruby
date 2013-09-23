# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require "revrise/version"

Gem::Specification.new do |s|
  s.name          = "revrise"
  s.version       = RevRise::VERSION
  s.platform   = Gem::Platform::RUBY
  s.authors       = ["Jonas Arnklint"]
  s.email         = ["jonas.arnklint@revrise.com"]
  s.homepage      = "https://github.com/arnklint/revrise-ruby"
  s.summary       = %q{The official Ruby wrapper for the RevRise API}
  s.description   = %q{Provides access to the RevRise API with auhtorization, event tracking and access to all the API resources}

  s.add_development_dependency('bundler', '~> 1.0')

  s.add_runtime_dependency('httparty', "0.11.0")

  s.files         = Dir.glob("lib/**/*") + %w(README.md)
  s.require_paths = ["lib"]
end
