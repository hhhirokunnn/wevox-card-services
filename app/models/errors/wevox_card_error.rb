# frozen_string_literal: true

module Errors
  class WevoxCardError < StandardError
    attr_accessor :status

    def initialize(status: 500, message: "Error")
      super(message)
      @status = status
    end
  end
end
