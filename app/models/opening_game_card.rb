class OpeningGameCard
  class << self
    include PlayCardService

    def create_by(player_id:)
      #player = Player.joins(:game).where(games: {started: true, finished: false}, players: {id: player_id})
      player = Player.joins(:game).find_by(players: {id: player_id})
      raise OpeningGameNotFoundError unless player.present?

      drawn_by(player: player)
    end

    def thrown(player_id:, card_id:)
      player = Player.joins(:game).where(games: {started: true, finished: false}, players: {id: player_id})
      play_card = PlayCard.find_by(card_id)
      raise OpeningGameNotFoundError unless player.present?
      raise CardNotFoundError unless card.present?

      thrown_by(play_card: play_card, player: player)
    end

    def init_in(game_id:)
      opening_game = Game.includes(:players).where(games: {started: true, finished: false, id: game_id})
      raise OpeningGameNotFoundError unless opening_game.present?

      initial_deal_in(game: opening_game, players: opening_game.players)
    end
  end

  class CardNotFoundError < Errors::WevoxCardError
    def initialize(message="CardNotFoundError")
      super(status: 404, message:  message)
    end
  end

  class OpeningGameNotFoundError < Errors::WevoxCardError
    def initialize(message="OpeningGameNotFoundError")
      super(status: 404, message:  message)
    end
  end
end