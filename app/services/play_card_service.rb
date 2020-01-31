# frozen_string_literal: true

module PlayCardService
  PLAYER_CARDS_COUNT = 5

  def initial_deal_in(game:, players:)
    PlayCard.transaction do
      cards = Card.select(:id).all
      play_cards = cards.shuffle.map do |card|
        PlayCard.create(game_id: game.id, card_id: card.id)
      end
      initial_deal(play_cards: play_cards[0..players.size * 5 - 1], players: players)
    end
  end

  def drawn_by(player:)
    PlayCard.transaction do
      play_card = PlayCard.find_by(game_id: player.game_id, status: "initialized")
      raise GameNotStartedError unless play_card

      deal(play_card: play_card, player: player)
    end
  end

  def throw(play_card:)
    play_card.status = "thrown"
    play_card.save
    play_card
  end

  private

  def initial_deal(play_cards:, players:)
    return if play_cards.empty?

    is_complete_dealt = play_cards.size <= (players.size - 1) * PLAYER_CARDS_COUNT
    dealing_players = is_complete_dealt ? players[1..-1] : players
    deal(play_card: play_cards.first, player: dealing_players.first)
    initial_deal(play_cards: play_cards[1..-1], players: dealing_players)
  end

  def deal(play_card:, player:)
    play_card.player_id = player.id
    play_card.status = "drawn"
    play_card.save
    play_card
  end

  class GameNotStartedError < Errors::WevoxCardError
    def initialize(message="GameNotStartedError")
      super(status: 400, message:  message)
    end
  end
end
