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
      creator = CreateTrelloCard.new(board_name: destination_board, list_name: destination_list, card_name: source_card.name)
      creator.first_or_create
    end
  end

  def source_cards
    l = TrelloLookup.list(source_board, source_list)
    l.cards
  end

end; end


