# frozen_string_literal: true

require_relative "lib/singl"

Gem::Specification.new do |spec|
  spec.name          = "singl"
  spec.version       = Singl::VERSION
  spec.authors       = ["RafaelPAndrade"]
  spec.license       = "MIT"

  spec.summary       = "Turning instance methods into singletons"
  spec.description = <<~DESC
    Given a class, it will extract all instance methods taking no arguments into singleton methods receiving self as first argument
  DESC
  spec.homepage = "https://web.ist.utl.pt/projects/#{spec.name}"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.7.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/RafaelPAndrade/#{spec.name}"
  spec.metadata["changelog_uri"] = "#{spec.metadata["source_code_uri"]}/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
