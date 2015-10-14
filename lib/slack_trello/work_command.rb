module SlackTrello; class WorkCommand

  attr_reader :parser, :webhook_url

  def initialize(args, webhook_url)
    @parser = ResponseParser.new(args)
    @webhook_url = webhook_url
  end

  def run
    return list_not_found_message unless trello_card_creator.trello_list

    trello_card
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

  private

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
    @card ||= trello_card_creator.first_or_create
  end

  def trello_board_name
    "#{parser.channel_name.titleize} Backlog"
  end

  def trello_list_name
    'From Chat'
  end

  def list_not_found_message
    "A Trello list named #{trello_list_name} must be added to the '#{trello_board_name}' board for the work command to function."
  end

  def success_message
    ":mega: [#{parser.user_name}] has created a new work card: <#{trello_card.short_url}|#{parser.text.strip}>"
  end

  def card_title
    "(UNSIZED) #{parser.text.strip} {tag???}"
  end

end; end

