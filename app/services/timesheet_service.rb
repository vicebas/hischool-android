# frozen_string_literal: true

class TimesheetService < ApplicationService
  def initialize(student_id, timesheet_params)
    @student = Student.find student_id
    @timesheet_params = timesheet_params
    @timesheet = nil
  end

  def call
    # TODO: Verificações
    create
  end

  def create
    @teacher = Timesheet.create(@timesheet_params.merge(student: @student))
  end
end
