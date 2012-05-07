# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "revrise/version"

Gem::Specification.new do |s|
  s.name        = "revrise"
  s.version     = RevRise::VERSION
  s.authors     = ["Jonas Arnklint"]
  s.email       = ["jonas.a@revrise.com"]
  s.homepage    = "https://github.com/arnklint/revrise-ruby"
  s.summary     = %q{Track events and gain insightful actionable metrics through RevRise}
  s.description = %q{Track events and gain insightful actionable metrics through RevRise}

  s.rubyforge_project = "revrise"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ">=2.10.0"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end
