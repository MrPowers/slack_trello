require "active_support/core_ext/string"
require "slack-notifier"

require "slack_trello/version"

def require_all(pattern)
  root = File.expand_path("../", File.dirname(__FILE__))
  Dir.glob("#{root}/#{pattern}/**/*.rb").sort.each { |path| require path }
end

require_all("lib/slack_trello/slack_helpers")
require_all("lib/slack_trello/trello_helpers")
require_all("lib/slack_trello/commands")

module SlackTrello
end
