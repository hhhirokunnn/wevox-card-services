# frozen_string_literal: true

class Game < ApplicationRecord
  has_many :players
  has_many :users, through: :players

  has_many :play_cards
  has_many :cards, through: :play_cards

  scope :ready, -> { where(started: false, finished: false) }
  scope :active, -> { where(finished: false) }
end
