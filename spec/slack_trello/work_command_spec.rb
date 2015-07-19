require 'spec_helper'

module SlackTrello; describe WorkCommand do

  let(:work) do
    args = {
      "token" => "gIkuvaNzQIHg97ATvDxqgjtO",
      "team_id" => "T0001",
      "team_domain" => "example",
      "channel_id" => "C2147483705",
      "channel_name" => "test",
      "user_id" => "U2147483697",
      "user_name" => "Steve",
      "command" => "/weather",
      "text" => "94070"
    }
    WorkCommand.new(args, "webhook url")
  end

  context "#run" do
    it "runs the code" do
      trello_card_creator = double
      expect(work).to receive(:trello_card_creator).twice.and_return(trello_card_creator)
      expect(trello_card_creator).to receive(:trello_board).and_return true
      expect(trello_card_creator).to receive(:trello_list).and_return true

      expect(work).to receive(:trello_card)

      expect(work).to receive(:success_message).and_return("success message")
      speaker = double
      expect(work).to receive(:speaker).and_return speaker
      expect(speaker).to receive(:speak).with "success message"
      expect(work.run).to eq "You should see a notification with a link. If not, the card might not have been created."
    end
  end

end; end


