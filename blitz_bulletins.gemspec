# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "blitz_bulletins/version"

Gem::Specification.new do |s|
  s.name        = "blitz_bulletins"
  s.version     = BlitzBulletins::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Brian V. Hughes"]
  s.email       = ["brianvh@dartmouth.edu"]
  s.homepage    = ""
  s.summary     = %(#{s.name}-#{s.version})
  s.description = %{Parsing BlitzMail Bulletins data files to extract lists of topics and posters.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'thor', '~> 0.14.6'
  s.add_dependency 'net-dnd', '~> 1.1.2'

  s.add_development_dependency 'bundler', '~> 1.0.21'
  s.add_development_dependency 'rspec', '~> 2.7.0'
  s.add_development_dependency 'aruba', '~> 0.3.7'
end
