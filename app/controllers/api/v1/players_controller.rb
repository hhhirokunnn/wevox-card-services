# frozen_string_literal: true

module Api
  module V1
    class PlayersController < Api::ApiBaseController
      def index
        render status: :ok, json: {status: 200, message: "created", data: {}}
      end

      def create; end

      def start_game; end
    end
  end
end
