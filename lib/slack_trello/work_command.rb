module SlackTrello; class WorkCommand

  attr_accessor :trello_card

  attr_reader :parser, :webhook_url

  def initialize(args, webhook_url)
    @parser = ResponseParser.new(args)
    @webhook_url = webhook_url
  end

  def run
    return board_not_found_message unless trello_board
    return list_not_found_message unless trello_list

    create_trello_card
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

  private

  def speaker
    Speaker.new(
      {
        webhook_url: webhook_url,
        channel: parser.channel_name,
        username: parser.user_name
      }
    )
  end

  def trello_board
    @trello_board ||= Trello::Board.all.find do |b|
      b.name.downcase == trello_board_name.downcase
    end
  end

  def trello_list
    @trello_list ||= trello_board.lists.find do |l|
      l.name == "From Chat"
    end
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

  def create_trello_card
    card = Trello::Card.new
    card.name = card_title
    card.list_id = trello_list.id
    card.save
    card.due = Time.now + 30.days
    card.pos = "bottom"
    card.save
    self.trello_card = card
  end

end; end
