
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "revoke/version"

Gem::Specification.new do |spec|
  spec.name          = "revoke"
  spec.version       = Revoke::VERSION
  spec.authors       = ["Abhishek kanojia"]
  spec.email         = ["abhishek.kanojia3193@gmail.com"]

  spec.summary       = %q{Revoke lets you prevent model alteration on specific event.}
  spec.description   = %q{Revoke add the functionality to be prevented from updated after a specified period of time.}
  spec.homepage      = "https://github.com/abhishekkanojia/proto.git"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'activerecord'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'activerecord'
  spec.add_development_dependency 'rspec', '~> 3.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
