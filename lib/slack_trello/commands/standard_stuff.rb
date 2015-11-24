module SlackTrello; module Commands; module StandardStuff

  def list_not_found_message
    "A Trello list named #{trello_list_name} must be added to the '#{trello_board_name}' board for the command to function.  The Trello Bot user that is authenticated by your application must also be added to the board."
  end

  def help_message
%{:cry: Invalid format
Your message: #{text}
Example: #{example_command}
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

  def success_message
    ":mega: [#{slack_post_response.user_name}] has created a new trello card: <#{trello_card.short_url}|#{slack_post_response.text.strip}>"
  end

end; end; end

