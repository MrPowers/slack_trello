module SlackTrello; class WorkCommand

  attr_reader :parser, :webhook_url

  def initialize(args, webhook_url)
    @parser = ResponseParser.new(args)
    @webhook_url = webhook_url
  end

  def run
    return board_not_found_message unless trello_card_creator.trello_board
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
      list_name: "From Chat",
      card_name: card_title
    }
    @trello_card_creator ||= CreateTrelloCard.new(args)
  end

  def trello_card
    trello_card_creator.card
  end

  def trello_board_name
    "#{parser.channel_name.titleize} Backlog"
  end

  def board_not_found_message
    "A Trello board named '#{trello_board_name}' must be created and the Trello user in the codebase must be added to the board for the work command to function for this Slack room."
  end

  def list_not_found_message
    "A Trello list named 'From Chat' must be added to the '#{trello_board_name}' board for the work command to function."
  end

  def success_message
    ":trello: [#{parser.user_name}] has created a new work card: <#{trello_card.short_url}|#{parser.text.strip}>"
  end

  def card_title
    size = "(UNSIZED)"
    title = parser.text.strip
    tag = "{tag???}"
    [size, title, tag].join(" ")
  end

end; end
