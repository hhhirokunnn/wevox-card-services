# frozen_string_literal: true

module Api
  class PlayerCard
    include ActiveModel::Model
    include PlayCardService
    attr_accessor :id, :title, :status
    attr_accessor :game_id
    attr_accessor :player

    class << self
      def all(game_id:)
        game_situation = Game.situation(game_id)
        # TODO: KIMOI
        player_cards = game_situation.players.flat_map do |player|
          game_situation.play_cards.map do |play_card|
            Api::PlayerCard.new(play_card: play_card, player: player) if play_card.player_id == player.id
          end
        end
        player_cards.compact
      end

      def create(game_id:, player_id:)
        opening_game = Api::OpeningGame.find(game_id: game_id)
        raise OpeningGameNotFoundError unless opening_game

        player = opening_game.players.find {|p| p.id == player_id }
        PlayCardService.drawn_by(player)
        all(game_id: game_id)
      end

      def create_all(game_id:)
        opening_game = Api::OpeningGame.find(game_id: game_id)
        raise OpeningGameNotFoundError unless opening_game

        initial_deal_in(opening_game: opening_game)
        all(game_id: game_id)
      end
    end

    private

    def initialize(play_card:, player:)
      @id = play_card.id
      @status = play_card.status
      @game_id = play_card.game_id
      # TODO: create play_card.title column and delete play_card.card_id for performance
      @title = play_card.card.title
      @player = player.present? ? Api::OpeningGamePlayer.new(player: player) : nil
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
