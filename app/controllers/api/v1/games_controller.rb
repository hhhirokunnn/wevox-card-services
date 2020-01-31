# frozen_string_literal: true

module Api
  module V1
    class GamesController < Api::ApiBaseController
      def index
        opening_games = Api::OpeningGame.all
        render_ok preload: opening_games
      end

      def show
        opening_game = Api::OpeningGame.find(game_id: params[:id])
        render_ok preload: opening_game
      rescue StandardError => e
        render_error error: e
      end

      def create
        new_game = Api::OpeningGame.create(user: @current_user)
        render_ok preload: new_game
      rescue PlayerDoingGameError => e
        render_error error: e, message: "player playing the other game"
      rescue StandardError => e
        render_error error: e
      end

      def destroy
        owner = GameOwner.new(user: @current_user)
        game = owner.close_game
        render_ok preload: game
      rescue GameNotFoundError => e
        render_error error: e, message: "game not found"
      rescue StandardError => e
        render_error error: e
      end

      def start_game
        owner = GameOwner.new(user: @current_user)
        opening_game = owner.start_game
        render_ok preload: opening_game
      rescue GameNotFoundError => e
        render_error error: e, message: "game not found"
      rescue GameStartedError => e
        render_error error: e, message: "game already started"
      rescue StandardError => e
        render_error error: e
      end

      # def out_game; end
    end
  end
end
