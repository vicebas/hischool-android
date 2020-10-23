# frozen_string_literal: true

# == Schema Information
#
# Table name: grade_units
#
#  id             :bigint(8)        not null, primary key
#  grade_id       :bigint(8)
#  unit_id        :bigint(8)
#  starts_on      :datetime         not null
#  ends_on        :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  total_lectures :integer
#

class GradeUnit < ApplicationRecord
  belongs_to :grade
  belongs_to :unit
  belongs_to :group
  has_many :messages
  has_many :timesheets
  has_many :grade_unit_students, dependent: :delete_all
  has_many :grade_unit_teachers, dependent: :delete_all
  has_many :students, through: :grade_unit_students
  has_many :teachers, through: :grade_unit_teachers

  before_create :calculate_total_lectures

  delegate :branch_id, to: :grade

  def calculate_total_lectures
    total_lectures = 20
  end

  def teacher_clock_in
    grade_unit_teachers.first.teacher_clock_in
  end
end
