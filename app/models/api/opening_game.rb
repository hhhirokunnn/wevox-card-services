# frozen_string_literal: true

module Api
  class OpeningGame
    include ActiveModel::Model
    attr_accessor :id, :started, :finished
    attr_accessor :players

    def initialize(game:, players:)
      @id = game.id
      @started = game.started
      @finished = game.finished
      @players = players.map {|p| OpeningGamePlayer.new(player: p) }
    end

    class OpeningGamePlayer
      include ActiveModel::Model
      attr_accessor :id, :name

      def initialize(player:)
        @id = player.id
        @name = player.user.name
      end
    end

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
