module SlackTrello; module Commands; class CreateCard

  include SlackTrello::SlackHelpers::TextParser

  attr_reader :parser, :webhook_url

  def initialize(args, webhook_url)
    @parser = SlackTrello::SlackHelpers::ResponseParser.new(args)
    @webhook_url = webhook_url
  end

  def run
    return help_message unless valid_text_format?
    return help_message unless num_args == 2
    return list_not_found_message unless trello_card_creator.trello_list

    trello_card
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

  private

  def help_message
%{:cry: Invalid format
Your message: #{text}
Example: /card (trello_board trello_list) card title
If the Trello board/list has spaces, replace them with underscores
For example, Some Board Name => some_board_name
}
  end

  def speaker
    args = {
      webhook_url: webhook_url,
      channel: parser.channel_name,
      username: parser.user_name
    }
    SlackTrello::SlackHelpers::Speaker.new(args)
  end

  def trello_card_creator
    args = {
      board_name: trello_board_name,
      list_name: trello_list_name,
      card_name: card_title
    }
    @trello_card_creator ||= SlackTrello::TrelloHelpers::CreateCard.new(args)
  end

  def trello_card
    @card ||= trello_card_creator.first_or_create
  end

  def trello_board_name
    args[0]
  end

  def trello_list_name
    args[1]
  end

  def list_not_found_message
    "A Trello list named #{trello_list_name} must be added to the '#{trello_board_name}' board for this command to function."
  end

  def success_message
    ":mega: [#{parser.user_name}] has created a new trello card: <#{trello_card.short_url}|#{parser.text.strip}>"
  end

  def card_title
    text_message
  end

  def text
    parser.text
  end

end; end; end

