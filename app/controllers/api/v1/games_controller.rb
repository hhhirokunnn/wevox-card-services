# frozen_string_literal: true

module Api
  module V1
    class GamesController < Api::ApplicationController
      def index
        active_games = Game.active
        render status: :ok, json: {data: {games: active_games}}
      end

      def show
        games = Api::OpeningGame.all
        return render status: :not_found, json: {data: {error: {message: "not found"}}} unless game

        render status: :ok, json: {data: games}
      end

      def create
        new_game = Api::OpeningGame.create(player: @current_user)
        render status: :ok, json: {data: new_game}
      rescue StandardError => e
        render status: :internal_server_error,
               json:   {data: {error: {content: e.message, message: "internal server error"}}}
      end

      def destroy
        game = Game.create!
        render status: :ok, json: {data: {game: game}}
      rescue StandardError => e
        render status: :internal_server_error, json: {data: {error: {content: e, message: "internal server error"}}}
      end

      def start_game; end

      def out_game; end
    end
  end
end
