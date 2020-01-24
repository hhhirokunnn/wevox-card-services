# frozen_string_literal: true

class User < ActiveRecord::Base
  has_many :players
  has_many :users, through: :players

  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :password,
            length: {minimum: 6},
            if:     -> { new_record? || !password.nil? }

  def active_player
    players.joins(:game).find_by(games: {finished: false})
  end
end
