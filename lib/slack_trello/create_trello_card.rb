module SlackTrello; class CreateTrelloCard

  attr_reader :board_name, :list_name, :card_name

  def initialize(args)
    @board_name = args.fetch(:board_name)
    @list_name = args.fetch(:list_name)
    @card_name = args.fetch(:card_name)
  end

  def card
    return @card if @card
    card = Trello::Card.new
    card.name = card_name
    card.list_id = trello_list.id
    card.save
    @card = card
  end

  def trello_board
    @trello_board ||= Trello::Board.all.find do |b|
      spaceify(b.name) == spaceify(board_name)
    end
  end

  def trello_list
    @trello_list ||= trello_board.lists.find do |l|
      spaceify(l.name) == spaceify(list_name)
    end
  end

  private

  def spaceify(str)
    str.gsub(/-|_/, " ").downcase
  end

end; end

