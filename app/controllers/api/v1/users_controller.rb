# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::ApplicationController

      skip_before_action :authorize_request, only: [:create]

      def index
        render status: 200, json: { status: 200, message: 'created', data: {} }
      end

      def create
        new_user = User.new(name: create_params[:user_name],password: create_params[:password])
        return render status: 200, json: { message: 'created', data: {} } if new_user.save
        render status: 400, json: { message: 'not created', data: { error: new_user.errors } }
      end

      private

      def create_params
        params.permit(:user_name, :password)
      end
    end
  end
end
