# frozen_string_literal: true

module Api
  module V1
    class SessionsController < Api::ApplicationController
      protect_from_forgery
      before_action :authorize_request, except: :create

      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          @decoded = JsonWebToken.decode(header)
          # @current_user = User.find(@decoded[:user_id])
          @current_user = 'aa'
        rescue ActiveRecord::RecordNotFound => e
          render json: { errors: e.message }, status: :unauthorized
        rescue JWT::DecodeError => e
          render json: { errors: e.message }, status: :unauthorized
        end
      end

      def index
        render json: { data: @decoded }, status: 200
      end

      def create
        token = JsonWebToken.encode(user_id: create_params[:username])
        time = Time.now + 1.hours.to_i
        render json: { token: token, exp: time.strftime('%m-%d-%Y %H:%M'), payload: create_params }, status: :ok
        # @user = User.find_by_email(params[:email])
        # if @user&.authenticate(params[:password])
        #  token = JsonWebToken.encode(user_id: @user.id)
        #  time = Time.now + 24.hours.to_i
        #  render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
        #                 username: @user.username }, status: :ok
        # else
        #  render json: { error: 'unauthorized' }, status: :unauthorized
        # end
      end

      # def destroy
      # end

      private

      def create_params
        params.permit(:username)
      end
    end
  end
end
