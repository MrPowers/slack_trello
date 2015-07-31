require 'spec_helper'

module SlackTrello; describe CreateCardCommand do

  let(:create_card) do
    args = {
      "token" => "gIkuvaNzQIHg97ATvDxqgjtO",
      "team_id" => "T0001",
      "team_domain" => "example",
      "channel_id" => "C2147483705",
      "channel_name" => "test",
      "user_id" => "U2147483697",
      "user_name" => "Steve",
      "command" => "/create_card",
      "text" => "(some_board some_list) some stuff blah"
    }
    CreateCardCommand.new(args, "webhook url")
  end

  context "#run" do
    it "runs the code" do
      trello_card_creator = double
      expect(create_card).to receive(:trello_card_creator).twice.and_return(trello_card_creator)
      expect(trello_card_creator).to receive(:trello_board).and_return true
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

end; end

