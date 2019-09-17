lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "abstrakt/version"

Gem::Specification.new do |spec|
  spec.name          = "abstrakt"
  spec.version       = Abstrakt::VERSION
  spec.authors       = ["Cyril ViXP"]
  spec.email         = ["cyrilvixp@gmail.com"]

  spec.summary       = %q{Adds abstract classes support to Ruby on declaration 
                          level}
  spec.description   = %q{Standard OOP abstract entities for proper SOLID 
                          implementation on class declaration level}
  spec.homepage      = "https://github.com/ViXP/abstrakt"
  spec.license       = "MIT"

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/ViXP/abstrakt"
  #spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.1.a"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
