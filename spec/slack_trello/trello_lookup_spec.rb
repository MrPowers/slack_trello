require 'spec_helper'

module SlackTrello; describe TrelloLookup do

  context ".spaceify" do
    it "downcases and replaces hypens with spaces" do
      expect(TrelloLookup.spaceify("Some-List")).to eq "some list"
    end

    it "downcases and replaces underscores with spaces" do
      expect(TrelloLookup.spaceify("Some_LisT")).to eq "some list"
    end
  end

end; end

