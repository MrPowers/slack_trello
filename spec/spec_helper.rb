$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'slack_trello'

require_relative "./support/helpers.rb"

RSpec.configure do |config|
  config.include Support::Helpers
end

