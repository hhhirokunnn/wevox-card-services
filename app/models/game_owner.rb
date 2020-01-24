# frozen_string_literal: true

class GameOwner
  include ActiveModel::Model
  include GameService

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
    game = game_owner.active_player&.game
    raise GameNotFoundError unless game

    started_by(player: game_owner.active_player)
  end
end

class GameNotFoundError < StandardError
end
