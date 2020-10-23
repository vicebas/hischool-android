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


require "test_helper"

class GradeUnitStudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
