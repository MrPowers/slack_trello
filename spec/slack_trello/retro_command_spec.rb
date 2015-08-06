require 'spec_helper'

module SlackTrello; describe RetroCommand do

  let(:post_args) do
    {
      "token" => "gIkuvaNzQIHg97ATvDxqgjtO",
      "team_id" => "T0001",
      "team_domain" => "example",
      "channel_id" => "C2147483705",
      "channel_name" => "test",
      "user_id" => "U2147483697",
      "user_name" => "Steve",
      "command" => "/retro",
      "text" => "(some_list) some stuff blah"
    }
  end

  let(:retro) do
    RetroCommand.new(post_args, "webhook url")
  end

  context "#run" do
    it "returns a help message if the format is invalid" do
      args = post_args.merge({"text" => "some_board some_list some stuff blah"})
      invalid_card = RetroCommand.new(args, "webhook url")
      expect(invalid_card).to receive(:list_names).and_return([])
      help_message = ":cry: Invalid format\nYour message: some_board some_list some stuff blah\nExample: /card (trello_list) card title\nAvailable list names: \nIf the Trello list has spaces, replace them with underscores\nFor example, Some List Name => some_list_name\n"
      expect(invalid_card.run).to eq help_message
    end

    it "returns a help message if the text is blank" do
      args = post_args.merge({"text" => ""})
      invalid_card = RetroCommand.new(args, "webhook url")
      expect(invalid_card).to receive(:list_names).and_return([])
      help_message = ":cry: Invalid format\nYour message: \nExample: /card (trello_list) card title\nAvailable list names: \nIf the Trello list has spaces, replace them with underscores\nFor example, Some List Name => some_list_name\n"
      expect(invalid_card.run).to eq help_message
    end

    it "returns a help message if an argument is not supplied" do
      args = post_args.merge({"text" => "() something"})
      invalid_card = RetroCommand.new(args, "webhook url")
      expect(invalid_card).to receive(:list_names).and_return([])
      help_message = ":cry: Invalid format\nYour message: () something\nExample: /card (trello_list) card title\nAvailable list names: \nIf the Trello list has spaces, replace them with underscores\nFor example, Some List Name => some_list_name\n"
      expect(invalid_card.run).to eq help_message
    end

    it "runs the code" do
      trello_card_creator = double
      expect(retro).to receive(:trello_card_creator).twice.and_return(trello_card_creator)
      expect(trello_card_creator).to receive(:trello_board).and_return true
      expect(trello_card_creator).to receive(:trello_list).and_return true

      expect(retro).to receive(:trello_card)

      expect(retro).to receive(:success_message).and_return("success message")
      speaker = double
      expect(retro).to receive(:speaker).and_return speaker
      expect(speaker).to receive(:speak).with "success message"
      expect(retro.run).to eq "You should see a notification with a link. If not, the card might not have been created."
    end
  end

  context "#trello_board_name" do
    it "returns the trello board name" do
      expect(retro.send(:trello_board_name)).to eq "Test Retro"
    end
  end

  context "#trello_list_name" do
    it "returns the trello list name" do
      expect(retro.send(:trello_list_name)).to eq "some_list"
    end
  end

  context "#card_title" do
    it "returns the text in the Trello card name" do
      expect(retro.send(:card_title)).to eq "some stuff blah -- Steve"
    end
  end

end; end
