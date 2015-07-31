require 'spec_helper'

module SlackTrello; describe CreateTrelloCard do

  let(:create_trello_card) do
    args = {
      board_name: "some_board",
      list_name: "Some-List",
      card_name: "a card"
    }
    CreateTrelloCard.new(args)
  end

  context "#spaceify" do
    it "downcases and replaces hypens with spaces" do
      expect(create_trello_card.send(:spaceify, "Some-List")).to eq "some list"
    end

    it "downcases and replaces underscores with spaces" do
      expect(create_trello_card.send(:spaceify, "Some_LisT")).to eq "some list"
    end
  end

end; end

