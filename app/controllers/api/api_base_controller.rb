# frozen_string_literal: true

module Api
  class ApiBaseController < ApplicationController
    include SessionHelper
    protect_from_forgery
    before_action :authorize_request
  end
end
