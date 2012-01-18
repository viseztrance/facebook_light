# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "facebook_light/version"

Gem::Specification.new do |s|
  s.name        = "facebook_light"
  s.version     = FacebookLight::VERSION
  s.author      = "Daniel Mircea"
  s.email       = ["daniel@viseztrance.com"]
  s.homepage    = "https://github.com/viseztrance/facebook_light"
  s.summary     = "Facebook Light"
  s.description = "A transparent facebook api implementation that doesn't obscure requests"

  s.rubyforge_project = "facebook_light"
  s.requirements << "curl"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_runtime_dependency "json"
  s.add_runtime_dependency "cocaine"
  s.add_runtime_dependency "activesupport"
  s.add_runtime_dependency "i18n"

  s.add_development_dependency "rake"
  s.add_development_dependency "sinatra"
end
