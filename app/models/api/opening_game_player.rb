# frozen_string_literal: true

module Api
  class OpeningGamePlayer
    include ActiveModel::Model
    attr_accessor :id, :name, :game_id

    def initialize(player:)
      @id = player.id
      @game_id = player.game_id
      # TODO: create player.name column for performance
      @name = player.user.name
    end
  end
end
