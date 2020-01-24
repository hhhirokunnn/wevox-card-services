# frozen_string_literal: true

module Api
  module V1
    class CardsController < Api::ApiBaseController
      def index
        render status: :ok, json: {status: 200, message: "created", data: {}}
      end

      def update
        render status: :ok, json: {status: 200, message: "created", data: {}}
      end

      def delete; end

      private

      def update_params
        params.permit(:game_id, :id)
      end
    end
  end
end
