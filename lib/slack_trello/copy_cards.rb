module SlackTrello; class CopyCards

  attr_reader :source_board, :source_list, :destination_board, :destination_list

  def initialize(source_board, source_list, destination_board, destination_list)
    @source_board = source_board
    @source_list = source_list
    @destination_board = destination_board
    @destination_list = destination_list
  end

  def run
    source_cards.each do |source_card|
      creator = CreateTrelloCard.new(destination_board, destination_list, source_card.name)
      creator.card
    end
  end

  def source_cards
    l = TrelloLookup.list(source_board, source_list)
    l.cards
  end

end; end


