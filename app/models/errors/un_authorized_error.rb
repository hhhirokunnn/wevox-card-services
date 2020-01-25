# frozen_string_literal: true

module Errors
  module Api
    class UnAuthorizedError < Errors::WevoxCardError
      def initialize(message="UnAuthorizedError")
        super(status: 401, message: message)
      end
    end
  end
end
