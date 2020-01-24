# frozen_string_literal: true

class Card < ApplicationRecord
  has_many :play_cards
  has_many :games, through: :play_cards
  has_many :players, through: :play_cards
end
