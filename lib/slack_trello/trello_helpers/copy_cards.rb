module SlackTrello; module TrelloHelpers; class CopyCards

  attr_reader :source_board, :source_list, :destination_board, :destination_list

  def initialize(args)
    @source_board = args.fetch(:source_board)
    @source_list = args.fetch(:source_list)
    @destination_board = args.fetch(:destination_board)
    @destination_list = args.fetch(:destination_list)
  end

  def run
    source_cards.each do |source_card|
      creator = CreateCard.new(board_name: destination_board, list_name: destination_list, card_name: source_card.name)
      creator.first_or_create
    end
  end

  def source_cards
    l = Lookup.list(source_board, source_list)
    l.cards
  end

end; end; end

