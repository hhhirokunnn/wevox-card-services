# frozen_string_literal: true

module Api
  module V1
    class CardsController < Api::ApplicationController
      def index
        render status: :ok, json: {status: 200, message: "created", data: {}}
      end

      def create; end

      def delete; end
    end
  end
end
