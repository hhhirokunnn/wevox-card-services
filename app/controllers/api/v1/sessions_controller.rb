# frozen_string_literal: true

module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authorize_request, only: [:create]

      def index
        render json: {data: @decoded}, status: :ok
      end

      def create
        user = User.find_by(name: create_params[:user_name])
        return render json: {error: "unauthorized"}, status: :unauthorized unless login?(user)

        token, time = login_token(user)
        render json: {token: token, exp: time.strftime("%m-%d-%Y %H:%M")}, status: :ok
      end

      private

      def create_params
        params.permit(:user_name, :password)
      end

      def login?(user)
        user&.authenticate(create_params[:password])
      end

      def login_token(user)
        token = JsonWebToken.encode(user_id: user.id)
        time = Time.zone.now + 24.hours.to_i
        [token, time]
      end
    end
  end
end
