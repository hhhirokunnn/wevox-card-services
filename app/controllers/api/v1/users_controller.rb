# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::ApplicationController
      skip_before_action :authorize_request, only: [:create]

      def create
        new_user = User.new(name: create_params[:user_name], password: create_params[:password])
        return render status: :ok, json: {message: "created", data: {}} if new_user.save

        render status: :bad_request, json: {message: "not created", data: {error: new_user.errors}}
      end

      def destroy
        unless @current_user.id.to_s == params[:id]
          return render status: :bad_request, json: {message: "not deleted", data: {error: "incorrect parameter"}}
        end

        @current_user.delete
        render status: :ok, json: {message: "deleted", data: {}}
      end

      private

      def create_params
        params.permit(:user_name, :password)
      end
    end
  end
end
