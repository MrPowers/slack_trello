module SlackTrello; class TrelloLookup

  class << self

    def board(board_name)
      @board ||= Trello::Board.all.find do |b|
        spaceify(b.name) == spaceify(board_name) && b.closed == false
      end
    end

    def list(board_name, list_name)
      b = board(board_name)
      @list ||= b.lists.find do |l|
        spaceify(l.name) == spaceify(list_name)
      end
    end

    def spaceify(str)
      str.gsub(/-|_/, " ").downcase
    end

  end

end; end

