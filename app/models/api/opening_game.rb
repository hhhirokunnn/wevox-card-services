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
        Api::OpeningGame.new(opening_games: games)
      end

      def create(player:)
        Player.transaction do
          new_game = Game.create!
          new_player = Player.transaction(requires_new: true) do
            Player.create!(game_id: new_game.id, user_id: player.id)
          end
          Api::OpeningGame.new(game: new_game, players: [new_player])
        end
      end
    end
  end
end
