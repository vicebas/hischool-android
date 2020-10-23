# frozen_string_literal: true

# == Schema Information
#
# Table name: grade_unit_students
#
#  id            :bigint(8)        not null, primary key
#  grade_unit_id :bigint(8)
#  student_id    :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


class GradeUnitStudent < ApplicationRecord
  belongs_to :grade_unit
  belongs_to :student

  has_many :timesheets, through: :grade_units

  delegate :unit, to: :grade_unit, allow_nil: false
end
