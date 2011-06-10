# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "atlas/version"

Gem::Specification.new do |s|
  s.name        = "atlas"
  s.version     = Atlas::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Alban Peignier"]
  s.email       = ["alban.peignier@dryade.net"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "atlas"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency('rspec')
  s.add_development_dependency('autotest')
  s.add_development_dependency('rake', '< 0.9')

  s.add_runtime_dependency('activerecord')
end
