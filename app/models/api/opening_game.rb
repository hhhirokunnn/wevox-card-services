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
        Api::OpeningGame.new(game: game, players: game.players)
      end

      def create(user:)
        raise PlayerDoingGameError.new if user.active_player

        owner = GameOwner.new(user: user)
        owner.open_game
      end
    end
  end

  class PlayerDoingGameError < StandardError
  end
end
