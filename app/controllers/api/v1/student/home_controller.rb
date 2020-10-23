# frozen_string_literal: true

class Api::V1::Student::HomeController < Api::V1::ApiController
  def index
    render json: {
      student: {
        email: @student.email,
        name: @student.name
      },
      last_presence_date: @student.timesheets.last.try(:registered_at) || "",
      chats_amount: @student.grade_units.includes(:grade, :unit).select(:grade_id, :unit_id).distinct.to_a.count
    }
  end
end
