# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blitz_bulletins/version"

Gem::Specification.new do |s|
  s.name        = "blitz_bulletins"
  s.version     = BlitzBulletins::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["TODO: Write your name"]
  s.email       = ["TODO: Write your email address"]
  s.homepage    = ""
  s.summary     = %q{TODO: Write a gem summary}
  s.description = %q{TODO: Write a gem description}

  s.rubyforge_project = "blitz_bulletins"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor', '~> 0.14.6'

  s.add_development_dependency 'bundler', '~> 1.0.10'
  s.add_development_dependency 'rspec', '~> 2.3.0'
  s.add_development_dependency 'aruba', '~> 0.3.2'
end
