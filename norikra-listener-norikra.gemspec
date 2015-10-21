# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "norikra-listener-norikra"
  spec.version       = "0.0.1"
  spec.authors       = ["Yoshihiro MIYAI"]
  spec.email         = ["msparrow17@gmail.com"]

  spec.summary       = %q{Norikra Listener plugin to send events to another Norikra.}
  spec.homepage      = "https://github.com/mia-0032/norikra-listener-norikra"
  spec.license       = "GPL v2"

  spec.platform      = "java"
  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rspec-mocks"
  spec.add_runtime_dependency     "norikra", ">= 1.3.0"
  spec.add_runtime_dependency     "norikra-client", ">= 1.3.0"
end
