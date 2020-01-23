# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController

      skip_before_action :authorize_request, only: [:create]

      def index
        render json: { data: @decoded }, status: 200
      end

      def create
        @current_user = User.find_by_name(create_params[:user_name])
        if @current_user&.authenticate(create_params[:password])
          token = JsonWebToken.encode(user_id: @current_user.id)
          time = Time.now + 24.hours.to_i
          render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M") }, status: :ok
        else
          render json: { error: 'unauthorized' }, status: :unauthorized
        end
      end

      private

      def create_params
        params.permit(:user_name, :password)
      end
    end
  end
end
