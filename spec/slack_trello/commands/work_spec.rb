require 'spec_helper'

module SlackTrello; module Commands; describe Work do

  let(:work) do
    custom_args = {
      "command" => "/work",
      "text" => "This is something we need to do"
    }
    Work.new(slack_args.merge(custom_args), "webhook url")
  end

  context "#run" do
    it "runs the code" do
      trello_card_creator = double
      expect(work).to receive(:trello_card_creator).and_return(trello_card_creator)
      expect(trello_card_creator).to receive(:trello_list).and_return true

      expect(work).to receive(:trello_card)

      expect(work).to receive(:success_message).and_return("success message")
      speaker = double
      expect(work).to receive(:speaker).and_return speaker
      expect(speaker).to receive(:speak).with "success message"
      expect(work.run).to eq "You should see a notification with a link. If not, the card might not have been created."
    end
  end

  context "card_desc" do
    it "returns the boilerplate card description" do
      expected = "Value Proposition\n------------\n\nAs a **<type of user>**, I want **<some goal>** so that **<some reason>**.\n\n\n------------------\n\nAcceptance Criteria\n--------------------\n\nI will consider value delivered when **<describe here in plain language> AND the Acceptance Criteria Checklist below has been met**.\n\n---------------\n\n*** << Link to Product Card (if appropriate) >>> ***\n\n---------------\n\n*** <<< Link to Any Epic Cards (if appropriate) >>> ***\n\n---------------\n\n*** <<< ATTACH ANY SUPPORT DOCUMENTS AND INFORMATION HERE >>> ***"
      expect(work.send(:card_desc)).to eq expected
    end
  end

end; end; end

