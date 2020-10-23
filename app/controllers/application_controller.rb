# frozen_string_literal: true

require "application_responder"

class ApplicationController < ActionController::Base
  self.responder = ApplicationResponder
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

  rescue_from ActiveRecord::RecordInvalid do |exception|
    render json: exception.record.first_error_message, status: 422, location: request.env["PATH_INFO"]
  end

  def handle_record_not_found
    render json: "", status: 404
  end

  protected

  def current_admin
    current_app_admin
  end
end
