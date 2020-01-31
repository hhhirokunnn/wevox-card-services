# frozen_string_literal: true

class GameOwner
  include ActiveModel::Model
  include GameService
  include PlayCardService

  attr_accessor :game_owner

  def initialize(user:)
    @game_owner = user
  end

  def open_game
    opened_by(user: game_owner)
  end

  def close_game
    # TODO: is_owner?
    game = game_owner.active_player&.game
    raise GameNotFoundError unless game

    closed_by(player: game_owner.active_player)
  end

  def start_game
    # TODO: is_owner?
    puts 'aaaaa'
    puts game_owner.active_player
    puts game_owner.active_player.game.id
    Game.transaction do
      player = game_owner.active_player
      opening_game = Api::OpeningGame.find(game_id: player.game.id)
      raise GameStartedError if opening_game.started

      initial_deal_in(game: opening_game, players: opening_game.players)
      started_game = started_by(player: player)
      Api::OpeningGame.find(game_id: started_game.id)
    end
  end
end

class GameNotFoundError < Errors::WevoxCardError
  def initialize(message="GameNotFoundError")
    super(status: 404, message:  message)
  end
end

class GameStartedError < Errors::WevoxCardError
  def initialize(message="GameStartedError")
    super(status: 405, message:  message)
  end
end
