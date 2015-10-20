module SlackTrello; module Commands; class CopyCards

  include SlackTrello::SlackHelpers::TextParser

  attr_reader :slack_post_response, :webhook_url

  def initialize(slack_post_args, webhook_url)
    @slack_post_response = OpenStruct.new(slack_post_args)
    @webhook_url = webhook_url
  end

  def run
    return help_message unless valid_text_format?
    return help_message unless num_args == 4

    card_copier.run
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

  private

  def help_message
%{:cry: Invalid format
Your message: #{slack_post_response.text}
Example: /copy_cards (source_board, source_list, destination_board, destination_list)
}
  end

  def speaker
    args = {
      webhook_url: webhook_url,
      channel: slack_post_response.channel_name,
      username: slack_post_response.user_name
    }
    SlackTrello::SlackHelpers::Speaker.new(args)
  end

  def card_copier
    args = {
      source_board: source_board_name,
      source_list: source_list_name,
      destination_board: destination_board_name,
      destination_list: destination_list_name
    }
    @card_copier ||= SlackTrello::TrelloHelpers::CopyCards.new(args)
  end

  def source_board_name
    args[0]
  end

  def source_list_name
    args[1]
  end

  def destination_board_name
    args[2]
  end

  def destination_list_name
    args[3]
  end

  def success_message
    ":mega: [#{slack_post_response.user_name}] has copied all the cards from the #{source_list_name} of the #{source_board_name} to the #{destination_list_name} of the #{destination_board_name}"
  end

end; end; end

