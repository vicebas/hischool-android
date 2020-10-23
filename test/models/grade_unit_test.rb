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

require "test_helper"

class GradeUnitTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
