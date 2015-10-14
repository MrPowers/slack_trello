module SlackTrello; class CreateTrelloCard

  attr_reader :board_name, :list_name, :card_name

  def initialize(args)
    @board_name = args.fetch(:board_name)
    @list_name = args.fetch(:list_name)
    @card_name = args.fetch(:card_name)
  end

  def card
    return @card if @card
    @card = Trello::Card.new
    @card.name = card_name
    @card.list_id = trello_list.id
    @card.save
  end

  def trello_list
    TrelloLookup.list(board_name, list_name)
  end

end; end

