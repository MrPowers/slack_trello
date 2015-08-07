module SlackTrello; class RetroCommand

  include TextParser

  attr_reader :parser, :webhook_url

  def initialize(args, webhook_url)
    @parser = ResponseParser.new(args)
    @webhook_url = webhook_url
  end

  def run
    return help_message unless valid_text_format?
    return help_message unless num_args == 1
    return board_not_found_message unless trello_card_creator.trello_board
    return list_not_found_message unless trello_card_creator.trello_list

    trello_card
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

  private

  def help_message
%{:cry: Invalid format
Your message: #{text}
Example: /card (trello_list) card title
Available list names: #{list_names.join(", ")}
If the Trello list has spaces, replace them with underscores
For example, Some List Name => some_list_name
}
  end

  def speaker
    args = {
      webhook_url: webhook_url,
      channel: parser.channel_name,
      username: parser.user_name
    }
    Speaker.new(args)
  end

  def trello_card_creator
    args = {
      board_name: trello_board_name,
      list_name: trello_list_name,
      card_name: card_title
    }
    @trello_card_creator ||= CreateTrelloCard.new(args)
  end

  def trello_card
    trello_card_creator.card
  end

  def trello_board_name
    "#{parser.channel_name.titleize} Retro"
  end

  def trello_list_name
    args[0]
  end

  def board_not_found_message
    "A Trello board named '#{trello_board_name}' must be created and the Trello user in the codebase must be added to the board for this command to function for this Slack room."
  end

  def list_not_found_message
    "A Trello list named #{trello_list_name} must be added to the '#{trello_board_name}' board for this command to function."
  end

  def success_message
    ":mega: [#{parser.user_name}] has created a new trello card: <#{trello_card.short_url}|#{parser.text.strip}>"
  end

  def card_title
    "#{text_message} -- #{parser.user_name}"
  end

  def text
    parser.text
  end

  def list_names
    trello_card_creator.trello_board.lists.map do |list|
      list.name.parameterize.underscore
    end
  end

end; end

