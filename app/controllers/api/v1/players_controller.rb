# frozen_string_literal: true

module Api
  module V1
    class PlayersController < Api::ApplicationController

      def index
        render status: 200, json: { status: 200, message: 'created', data: {} }
      end

      def create; end

      def start_game; end
    end
  end
end
