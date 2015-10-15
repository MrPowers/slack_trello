require 'spec_helper'

module SlackTrello; module Commands; describe CopyCards do

  let(:copy_cards) do
    custom_args = {
      "command" => "/copy_cards",
      "text" => "(source_board source_list destination_board destination_list)"
    }
    CopyCards.new(slack_args.merge(custom_args), "webhook url")
  end

  context "#run" do

    it "returns a help message if the format is invalid" do
      custom_args = {
        "command" => "/copy_cards",
        "text" => "some_board some_list some stuff blah"
      }
      invalid_copy = CopyCards.new(slack_args.merge(custom_args), "webhook url")
      help_message = ":cry: Invalid format\nYour message: some_board some_list some stuff blah\nExample: /copy_cards (source_board, source_list, destination_board, destination_list)\n"
      expect(invalid_copy.run).to eq help_message
    end

    it "returns a help message if the text is blank" do
      custom_args = {
        "command" => "/copy_cards",
        "text" => ""
      }
      invalid_copy = CopyCards.new(slack_args.merge(custom_args), "webhook url")
      help_message = ":cry: Invalid format\nYour message: \nExample: /copy_cards (source_board, source_list, destination_board, destination_list)\n"
      expect(invalid_copy.run).to eq help_message
    end

    it "returns a help message if only one argument is supplied" do
      custom_args = {
        "command" => "/copy_cards",
        "text" => "(trello_board) something"
      }
      invalid_copy = CopyCards.new(slack_args.merge(custom_args), "webhook url")
      help_message = ":cry: Invalid format\nYour message: (trello_board) something\nExample: /copy_cards (source_board, source_list, destination_board, destination_list)\n"
      expect(invalid_copy.run).to eq help_message
    end

  def run
    return help_message unless valid_text_format?
    return help_message unless num_args == 4

    card_copier.run
    speaker.speak success_message
    "You should see a notification with a link. If not, the card might not have been created."
  end

    it "runs the code" do
      copier = double
      expect(copy_cards).to receive(:card_copier).and_return(copier)
      expect(copier).to receive(:run)

      expect(copy_cards).to receive(:success_message).and_return("success message")
      speaker = double
      expect(copy_cards).to receive(:speaker).and_return speaker
      expect(speaker).to receive(:speak).with "success message"
      expect(copy_cards.run).to eq "You should see a notification with a link. If not, the card might not have been created."
    end

  end

  context "#source_board_name" do
    it "returns the trello board name" do
      expect(copy_cards.send(:source_board_name)).to eq "source_board"
    end
  end

  context "#source_list_name" do
    it "returns the source list name" do
      expect(copy_cards.send(:source_list_name)).to eq "source_list"
    end
  end

  context "#destination_board_name" do
    it "returns the trello board name" do
      expect(copy_cards.send(:destination_board_name)).to eq "destination_board"
    end
  end

  context "#destination_list_name" do
    it "returns the destination list name" do
      expect(copy_cards.send(:destination_list_name)).to eq "destination_list"
    end
  end

end; end; end

