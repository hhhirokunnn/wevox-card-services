# frozen_string_literal: true

module Api
  class OpeningGames
    include ActiveModel::Model

    attr_accessor :opening_games
    attr_accessor :players

    class << self
      def all(player:)
        Player.transaction do
          new_game = Game.create!
          new_player = Player.transaction(requires_new: true) do
            Player.create!(game_id: new_game.id, user_id: player.id)
          end
          Api::OpeningGame.new(opening_game: new_game, player: new_player)
        end
      end
    end
  end
end
