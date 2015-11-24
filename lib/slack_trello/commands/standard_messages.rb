module SlackTrello; module Commands; module StandardMessages

  def list_not_found_message
    "A Trello list named #{trello_list_name} must be added to the '#{trello_board_name}' board for the command to function."
  end

  def help_message
%{:cry: Invalid format
Your message: #{text}
Example: #{example_command}
}
  end

end; end; end

