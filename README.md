# SlackTrello

The slack_trello gem makes it easy to parse POST requests sent to a Ruby application by the Slack API.  The gem is geared towards making Trello cards based on Slack POST requests, but the core modules and classes are generic and can be repourposed for other tasks as well.

The Slack [slash commands](https://api.slack.com/slash-commands) send POST requests like this:

```ruby
{
  "token" => "gIkuvaNzQIHg97ATvDxqgjtO",
  "team_id" => "T0001",
  "team_domain" => "example",
  "channel_id" => "C2147483705",
  "channel_name" => "test",
  "user_id" => "U2147483697",
  "user_name" => "Steve",
  "command" => "/some_command",
  "text" => "(some_arg another_arg) some stuff blah"
}
```

The slack_trello gem parses these POST params and makes Trello cards.

### Work Command

Example usage of this command in Slack (assume the command is run in the #pandas channel):

```
/work Do some important stuff
```

This will create a Trello card in the From Chat list of the Pandas Backlog Trello board.  The code can be invoked as follows:

```ruby
SlackTrello::Commands::Work.new(params, ENV["SLACK_WEBHOOK_URL"]).run
```

### Retro Command

Example usage of this command in Slack (assume the command is run in the #pandas channel):

```
/retro (questions) Why are we building that feature?
```

This will create a Trello card in the Questions list of the Pandas Retro Trello board.  The code can be invoked as follows:

```ruby
SlackTrello::Commands::Retro.new(params, ENV["SLACK_WEBHOOK_URL"]).run
```

### Card Command

Example usage of this command in Slack (this command can run in any channel and function the same):

```
/card (pandaland on_deck) Build a cool cmap
```

This will create a Trello card in the On Deck list of the Pandaland Trello board.  The code can be invoked as follows:

```ruby
SlackTrello::Commands::Card.new(params, ENV["SLACK_WEBHOOK_URL"]).run
```

### CopyCards Command

Example usage of this command in Slack (this command can run in any channel and function the same):

```
/copy_cards (recurring_engineering pandas pandaland on_deck)
```

This will copy all the cards from the the Pandas list of the Recurring Engineering Trello board to the On Deck list of the Pandaland Trello board.  The code can be invoked as follows:

```ruby
SlackTrello::Commands::CopyCards.new(params, ENV["SLACK_WEBHOOK_URL"]).run
```

## Usage

The [slack-responder](https://github.com/medivo/slack-responder) Rails application includes the slack_trello gem and demonstrates how a Rails application that responds to Slack POST requests can be set up.  Cloning the slack-responder application is the easiest way to get up-and-running with the slack_trello gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'slack_trello'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install slack_trello

