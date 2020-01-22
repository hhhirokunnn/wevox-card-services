# frozen_string_literal: true

module Api
  module V1
    class HelloController < ActionController::Base
      # Prevent CSRF attacks by raising an exception.
      # For APIs, you may want to use :null_session instead.
      protect_from_forgery with: :exception
      def index
        render status: 200, json: { status: 200, message: 'created', data: {} }
      end
    end
  end
end
