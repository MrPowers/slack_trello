module SlackTrello; module Commands; class Work

  attr_reader :slack_post_response, :webhook_url

  def initialize(slack_post_args, webhook_url)
    @slack_post_response = OpenStruct.new(slack_post_args)
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
      channel: slack_post_response.channel_name,
      username: slack_post_response.user_name
    }
    SlackTrello::SlackHelpers::Speaker.new(args)
  end

  def trello_card_creator
    args = {
      board_name: trello_board_name,
      list_name: trello_list_name,
      card_name: card_title,
      card_desc: card_desc
    }
    @trello_card_creator ||= SlackTrello::TrelloHelpers::CreateCard.new(args)
  end

  def trello_card
    @card ||= trello_card_creator.first_or_create
  end

  def trello_board_name
    "#{slack_post_response.channel_name.titleize} Backlog"
  end

  def trello_list_name
    'From Chat'
  end

  def list_not_found_message
    "A Trello list named #{trello_list_name} must be added to the '#{trello_board_name}' board for the work command to function."
  end

  def success_message
    ":mega: [#{slack_post_response.user_name}] has created a new work card: <#{trello_card.short_url}|#{slack_post_response.text.strip}>"
  end

  def card_title
    "(UNSIZED) #{slack_post_response.text.strip} {tag???}"
  end

  def card_desc
%q{Value Proposition
------------

As a **<type of user>**, I want **<some goal>** so that **<some reason>**.


------------------

Acceptance Criteria
--------------------

I will consider value delivered when **<describe here in plain language> AND the Acceptance Criteria Checklist below has been met**.

---------------

*** << Link to Product Card (if appropriate) >>> ***

---------------

*** <<< Link to Any Epic Cards (if appropriate) >>> ***

---------------

*** <<< ATTACH ANY SUPPORT DOCUMENTS AND INFORMATION HERE >>> ***}
  end

end; end; end

