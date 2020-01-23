# frozen_string_literal: true

class Game < ApplicationRecord
  scope :ready, -> { where(started: false, finished: false) }
  scope :active, -> { where(finished: false) }
end
