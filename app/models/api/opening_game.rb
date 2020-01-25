# frozen_string_literal: true

module Api
  class OpeningGame
    include ActiveModel::Model

    # OpeningGame
    attr_accessor :game
    validates :game, presence: true

    attr_accessor :players
    validates :players, presence: true
    validates :players, length: {maximum: 4}

    class << self
      def all
        games = Game.active.all
        games.map do |g|
          Api::OpeningGame.new(game: g, players: g.players)
        end
      end

      def find(game_id)
        game = Game.find_by(id: game_id)
        raise OpeningGameNotFoundError unless game || game&.players

        Api::OpeningGame.new(game: game, players: game&.players)
      end

      def create(user:)
        raise PlayerDoingGameError if user.active_player

        owner = GameOwner.new(user: user)
        owner.open_game
      end
    end
  end

  class PlayerDoingGameError < Errors::WevoxCardError
    def initialize(message="PlayerDoingGameError")
      super(status: 405, message:  message)
    end
  end

  class OpeningGameNotFoundError < Errors::WevoxCardError
    def initialize(message="OpeningGameNotFoundError")
      super(status: 404, message:  message)
    end
  end
end
