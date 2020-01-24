# frozen_string_literal: true

module GameService
  def opened_by(user:)
    Player.transaction do
      new_game = Game.create!
      new_player = Player.transaction(requires_new: true) do
        Player.create!(game_id: new_game.id, user_id: user.id)
      end
      Api::OpeningGame.new(game: new_game, players: [new_player])
    end
  end

  def closed_by(player:)
    Game.transaction do
      game = Game.find_by(id: player.game.id, started: true)
      game.finished = true
      game.save!
      game
    end
  end

  def started_by(player:)
    Game.transaction do
      game = Game.find(player.game.id)
      game.started = true
      game.save!
      game
    end
  end
end
