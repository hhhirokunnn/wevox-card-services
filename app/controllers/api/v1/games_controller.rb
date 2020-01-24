# frozen_string_literal: true

module Api
  module V1
    class GamesController < Api::ApiBaseController
      def index
        games = Api::OpeningGame.all
        render status: :ok, json: {data: games}
      end

      def show
        games = Api::OpeningGame.all
        return render status: :not_found, json: {data: {error: {message: "not found"}}} unless game

        render status: :ok, json: {data: games}
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
        game = owner.start_game
        render status: :ok, json: {data: {game: game}}
      rescue GameNotFoundError => e
        render status: :not_found, json: {data: {error: {content: e.class.to_s, message: "game not found"}}}
      rescue StandardError => e
        render status: :internal_server_error, json: {data: {error: {content: e, message: "internal server error"}}}
      end

      # def out_game; end
    end
  end
end
