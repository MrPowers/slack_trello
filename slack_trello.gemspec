# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'slack_trello/version'

Gem::Specification.new do |spec|
  spec.name          = "slack_trello"
  spec.version       = SlackTrello::VERSION
  spec.authors       = ["Matthew Powers"]
  spec.email         = ["matthewkevinpowers@gmail.com"]

  spec.summary       = %q{Using Slack slash commands to make cards on Trello boards.}
  spec.description   = %q{Helper methods to effectively use Slack & Trello with your team's Scrum processes.}
  spec.homepage      = "https://github.com/MrPowers/slack_trello"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"
  spec.add_dependency "ruby-trello"
  spec.add_dependency "slack-notifier"
end
