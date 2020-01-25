# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::ApiBaseController
      skip_before_action :authorize_request, only: [:create]

      def create
        new_user = User.new(name: create_params[:user_name], password: create_params[:password])
        return render_error error: UserNotCreatedError, message: new_user.errors unless new_user.save

        render_ok preload: new_user if new_user.save
      end

      def destroy
        unless @current_user.id.to_s == params[:id]
          return render_error error: UserNotDeletedError, message: "incorrect parameter"
        end

        @current_user.delete
        render_ok preload: @current_user
      end

      private

      def create_params
        params.permit(:user_name, :password)
      end
    end
  end
end

class UserNotCreatedError < Errors::WevoxCardError
  def initialize(message="UserNotCreatedError")
    super(status: 400, message:  message)
  end
end

class UserNotDeletedError < Errors::WevoxCardError
  def initialize(message="UserNotDeletedError")
    super(status: 400, message:  message)
  end
end
