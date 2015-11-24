module SlackTrello; module Commands; class Retro

  include StandardStuff
  include SlackTrello::SlackHelpers::TextParser

  attr_reader :slack_post_response, :webhook_url

  def initialize(slack_post_args, webhook_url)
    @slack_post_response = OpenStruct.new(slack_post_args)
    @webhook_url = webhook_url
  end

  def run
    return help_message unless valid_text_format?
    return help_message unless num_args == 1
    return list_not_found_message unless trello_card_creator.trello_list

    trello_card
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

  private

  def example_command
    "/retro (#{list_names.first}) blah blah blah"
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
    "#{slack_post_response.channel_name.titleize} Retro"
  end

  def trello_list_name
    args[0]
  end

  def card_title
    "#{text_message} -- #{slack_post_response.user_name}"
  end

  def list_names
    board = SlackTrello::TrelloHelpers::Lookup.board(trello_board_name)
    board.lists.map do |list|
      list.name.parameterize.underscore
    end
  end

end; end; end

