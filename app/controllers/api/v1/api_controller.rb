# frozen_string_literal: true

class Api::V1::ApiController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_profile
  include DeviseTokenAuth::Concerns::SetUserByToken

  private

  def authenticate_api_v1_user!
    if api_v1_user_signed_in?
      super
    else
      render json: { error: I18n.t("devise.failure.unauthenticated") }, status: 401
    end
  end

  def set_profile
    if current_api_v1_user.profile.is_a?(Student)
      @student = current_api_v1_user.student
    else
      @teacher = current_api_v1_user.teacher
    end
  end
end
