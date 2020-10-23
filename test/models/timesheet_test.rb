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

require "test_helper"

class TimesheetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
