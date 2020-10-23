# frozen_string_literal: true

class Api::V1::StudentController < Api::V1::ApiController
  def index
    render json: @student.user, status: 200
  end

  def update
    if @student.update(student_params.except(:user_attributes)) && @student.update(user_attributes: @student.user.attributes.merge(student_params[:user_attributes] || {}))
      render json: @student, status: 200
    else
      render json: { error: @student.errors.values.flatten.first }, status: 422
    end
  end

  private
  def student_params
    params.permit(:name, :cellphone, user_attributes: [:email])
  end
end
