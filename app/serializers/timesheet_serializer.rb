# frozen_string_literal: true

# == Schema Information
#
# Table name: timesheets
#
#  id            :bigint(8)        not null, primary key
#  grade_unit_id :bigint(8)
#  student_id    :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  registered_at :datetime
#

class TimesheetSerializer < ActiveModel::Serializer
  attributes :id, :student_name, :created_at

  def student_name
    object.student.name
  end

  def created_at
    I18n.localize(object.created_at, format: :descriptive_datetime)
  end
end
