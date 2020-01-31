# frozen_string_literal: true

module PlayCardService
  PLAYER_CARDS_COUNT = 5

  def initial_deal_in(opening_game:)
    PlayCard.transaction do
      cards = Card.select(:id).all
      play_cards = cards.shuffle.map do |card|
        PlayCard.create(game_id: opening_game.id, card_id: card.id)
      end
      players = opening_game.players
      initial_deal(play_cards: play_cards[0..players.size * 5 - 1], players: players)
    end
  end

  def drawn_by(player:)
    PlayCard.transaction do
      play_card = PlayCard.find_by(game_id: player.game_id, status: "initialized")
      play_card.update(player_id: player.id)
    end
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
    play_card.update(player_id: player.id, status: "drawn")
  end
end
