# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::ApplicationController
      skip_before_action :authorize_request, only: [:create]

      # for debug
      skip_before_action :authorize_request, only: [:index]
      def index
        render status: 200, json: { status: 200, message: 'created', data: { user: User.all } }
      end

      def create
        new_user = User.new(name: create_params[:user_name], password: create_params[:password])
        if new_user.save
          return render status: 200, json: { message: 'created', data: {} }
        end

        render status: 400, json: { message: 'not created', data: { error: new_user.errors } }
      end

      def destroy
        unless @current_user.id.to_s == params[:id]
          return render status: 400, json: { message: 'not deleted', data: { error: 'incorrect parameter' } }
        end

        @current_user.delete
        render status: 200, json: { message: 'deleted', data: {} }
      end

      private

      def create_params
        params.permit(:user_name, :password)
      end
    end
  end
end
