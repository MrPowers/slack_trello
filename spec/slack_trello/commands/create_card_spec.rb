require 'spec_helper'

module SlackTrello; module Commands; describe CreateCard do

  let(:create_card) do
    custom_args = {
      "command" => "/create_card",
      "text" => "(some_board some_list) some stuff blah"
    }
    CreateCard.new(slack_args.merge(custom_args), "webhook url")
  end

  context "#run" do
    it "returns a help message if the format is invalid" do
      custom_args = {
        "command" => "/create_card",
        "text" => "some_board some_list some stuff blah"
      }
      invalid_card = CreateCard.new(slack_args.merge(custom_args), "webhook url")
      help_message = ":cry: Invalid format\nYour message: some_board some_list some stuff blah\nExample: /card (trello_board trello_list) card title\n"
      expect(invalid_card.run).to eq help_message
    end

    it "returns a help message if the text is blank" do
      custom_args = {
        "command" => "/create_card",
        "text" => ""
      }
      invalid_card = CreateCard.new(slack_args.merge(custom_args), "webhook url")
      help_message = ":cry: Invalid format\nYour message: \nExample: /card (trello_board trello_list) card title\n"
      expect(invalid_card.run).to eq help_message
    end

    it "returns a help message if only one argument is supplied" do
      custom_args = {
        "command" => "/create_card",
        "text" => "(trello_board) something"
      }
      invalid_card = CreateCard.new(slack_args.merge(custom_args), "webhook url")
      help_message = ":cry: Invalid format\nYour message: (trello_board) something\nExample: /card (trello_board trello_list) card title\n"
      expect(invalid_card.run).to eq help_message
    end

    it "runs the code" do
      trello_card_creator = double
      expect(create_card).to receive(:trello_card_creator).and_return(trello_card_creator)
      expect(trello_card_creator).to receive(:trello_list).and_return true

      expect(create_card).to receive(:trello_card)

      expect(create_card).to receive(:success_message).and_return("success message")
      speaker = double
      expect(create_card).to receive(:speaker).and_return speaker
      expect(speaker).to receive(:speak).with "success message"
      expect(create_card.run).to eq "You should see a notification with a link. If not, the card might not have been created."
    end
  end

  context "#trello_board_name" do
    it "returns the trello board name" do
      expect(create_card.send(:trello_board_name)).to eq "some_board"
    end
  end

  context "#trello_list_name" do
    it "returns the trello list name" do
      expect(create_card.send(:trello_list_name)).to eq "some_list"
    end
  end

  context "#card_title" do
    it "returns the text in the Trello card name" do
      expect(create_card.send(:card_title)).to eq "some stuff blah"
    end
  end

end; end; end

