# frozen_string_literal: true

class Api::V1::Student::GradeUnitsController < Api::V1::ApiController
  def index
    @units = @student.grade_units.includes(:grade, :unit).select("DISTINCT ON (unit_id) *")
    render json: @units
  end

  def timesheets
    @timesheets = @student.timesheets
    render json: @timesheets
  end

  def create
    @timesheet = TimesheetService.call(@student.id, timesheet_params)
    if @timesheet.valid?
      render json: @timesheet, status: 200
    else
      render json: { error: @timesheet.errors.values.flatten.first }, status: 422
    end
  end

  private
  def timesheet_params
    params.permit(:grade_unit_id)
  end
end
