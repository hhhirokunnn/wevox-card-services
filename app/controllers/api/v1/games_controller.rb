# frozen_string_literal: true

module Api
  module V1
    class GamesController < Api::ApiBaseController
      def index
        opening_games = Api::OpeningGame.all
        render status: :ok, json: {data: opening_games}
      end

      def show
        opening_game = Api::OpeningGame.find(params[:id])
        return render status: :not_found, json: {data: {error: {message: "not found"}}} unless opening_game

        render status: :ok, json: {data: opening_game}
      end

      def create
        new_game = Api::OpeningGame.create(user: @current_user)
        render status: :ok, json: {data: new_game}
      rescue PlayerDoingGameError => e
        render status: :forbidden,
               json:   {data: {error: {content: e.message, message: "player playing the other game"}}}
      rescue StandardError => e
        render status: :internal_server_error,
               json:   {data: {error: {content: e.message, message: "internal server error"}}}
      end

      def destroy
        owner = GameOwner.new(user: @current_user)
        game = owner.close_game
        render status: :ok, json: {data: {game: game}}
      rescue GameNotFoundError => e
        render status: :not_found, json: {data: {error: {content: e.class.to_s, message: "game not found"}}}
      rescue StandardError => e
        render status: :internal_server_error, json: {data: {error: {content: e, message: "internal server error"}}}
      end

      def start_game
        owner = GameOwner.new(user: @current_user)
        opening_game = owner.start_game
        render status: :ok, json: {data: opening_game}
      rescue GameNotFoundError => e
        render status: :not_found, json: {data: {error: {content: e.class.to_s, message: "game not found"}}}
      rescue GameStartedError => e
        render status: :not_found, json: {data: {error: {content: e.class.to_s, message: "game already started"}}}
      rescue StandardError => e
        render status: :internal_server_error, json: {data: {error: {content: e, message: "internal server error"}}}
      end

      # def out_game; end
    end
  end
end
