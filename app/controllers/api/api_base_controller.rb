# frozen_string_literal: true

module Api
  class ApiBaseController < ApplicationController
    include SessionHelper
    protect_from_forgery
    before_action :authorize_request

    def render_ok(response_message: "ok", preload:)
      render status: :ok, json: {message: response_message, preload: preload}
    end

    def render_error(message: "error", error:)
      if error.is_a?(Errors::WevoxCardError)
        return render status: error.status, json: json_response(error: error, message: message)
      end

      render status: :internal_server_error, json: json_response(error: error, message: error.full_message)
    end

    private

    def json_response(error:, message:)
      {preload: {error: {content: error.message, message: message}}}
    end
  end
end
