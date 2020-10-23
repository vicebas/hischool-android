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

class GradeUnitSerializer < ActiveModel::Serializer
  attributes :id, :grade_id, :branch_id, :unit_name, :course_name, :pretty_start, :pretty_end, :attendance_percentage
  has_many :teachers, through: :grade_unit_teachers

  def pretty_start
    object.starts_on.strftime("%Y-%m-%d %H:%M")
  end

  def pretty_end
    object.ends_on.strftime("%Y-%m-%d %H:%M")
  end

  def unit_name
    object.unit.name
  end

  def course_name
    object.unit.course.name
  end

  def attendance_percentage
    50
  end
end
