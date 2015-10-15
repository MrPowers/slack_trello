require 'spec_helper'

module SlackTrello; module TrelloHelpers; describe Lookup do

  context ".spaceify" do
    it "downcases and replaces hypens with spaces" do
      expect(Lookup.spaceify("Some-List")).to eq "some list"
    end

    it "downcases and replaces underscores with spaces" do
      expect(Lookup.spaceify("Some_LisT")).to eq "some list"
    end
  end

end; end; end

