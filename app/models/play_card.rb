# frozen_string_literal: true

class PlayCard < ApplicationRecord
  belongs_to :card
  belongs_to :game
  belongs_to :player
end
