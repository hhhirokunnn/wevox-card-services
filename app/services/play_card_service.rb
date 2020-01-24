# frozen_string_literal: true

module PlayCardService
  def deal_at(game:)
    PlayCard.transaction do
      card_ids = Card.select(:id).all.map(&:id)
      card_ids.shuffle.map do |id|
        PlayCard.create(game_id: game.id, card_id: id)
      end
    end
  end
end
