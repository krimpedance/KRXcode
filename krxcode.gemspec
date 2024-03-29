# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "krxcode/version"

Gem::Specification.new do |spec|
  spec.name          = "KRXcode"
  spec.version       = Krxcode::VERSION
  spec.authors       = ["Krimpedance"]
  spec.email         = ["info@krimpedance.com"]

  spec.summary       = "Utilities for Xcode"
  spec.description   = "Utilities for Xcode."
  spec.homepage      = "https://github.com/krimpedance/KRXcode"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "krimpedance.com.stub" # no available

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/krimpedance/KRXcode"
    # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", ">= 2.1.4"
  spec.add_development_dependency "rake", ">= 12.3.3"

  spec.add_dependency 'thor'
  spec.add_dependency 'highline'
  spec.add_dependency "xcodeproj", ">= 1.22.0"
end
