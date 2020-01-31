# frozen_string_literal: true

module Api
  module V1
    class CardsController < Api::ApiBaseController
      #skip_before_action :authorize_request, only: [:index, :create, :destroy]

      def index
        game_id, player_id = [index_params[:game_id], index_params[:player_id]]
        #game = Game.joins(:players).find_by(games: {id: game_id, started: true, finished: false}, players: {id: player_id})
        game = Game.joins(:players).find_by(games: {id: game_id, started: true, finished: false}, players: {id: player_id, user_id: @current_user.id})
        raise BadRequest unless game

        play_cards = PlayCard.where(game_id: game_id)
        render status: :ok, json: {status: 200, message: "success", data: play_cards}
      end

      def create
        game_id, player_id = [create_params[:game_id], create_params[:player_id]]
        player = Player.joins(:game).find_by(games: {id: game_id, started: true, finished: false}, players: {id: player_id, user_id: @current_user.id})
        #player = Player.joins(:game).find_by(games: {id: game_id, started: true, finished: false}, players: {id: player_id})
        raise BadRequest unless player

        play_card = PlayCard.where(game_id: game_id).where.not(status: "thrown").first
        raise BadRequest unless play_card

        PlayCard.transaction do
          play_card.status = "drawn"
          play_card.player_id = player.id
          play_card.save
        end

        render status: :ok, json: {status: 200, message: "drawn", data: play_card}
      end

      def destroy
        game_id, player_id, id = [destroy_params[:game_id], destroy_params[:player_id], destroy_params[:id]]
        play_card = PlayCard.joins(:game)
                        .joins(:player)
                        .where(games: {id: game_id, started: true, finished: false},
                                 players: {id: player_id},
                                 play_cards: {id: id})
                        .where(players: {user_id: @current_user.id})
                        .where.not(status: "initialized").first
        raise BadRequest unless play_card

        PlayCard.transaction do
          play_card.status = "thrown"
          play_card.save
        end

        render status: :ok, json: {status: 200, message: "thrown", data: play_card}
      end

      private

      def index_params
        params.permit(:game_id, :player_id)
      end

      def create_params
        params.permit(:game_id, :player_id)
      end

      def destroy_params
        params.permit(:game_id, :id, :player_id)
      end
    end
    class BadRequest < Errors::WevoxCardError
      def initialize(message="BadRequest")
        super(status: 400, message:  message)
      end
    end
  end
end
