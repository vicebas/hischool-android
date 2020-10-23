# frozen_string_literal: true

# == Schema Information
#
# Table name: grades
#
#  id         :bigint(8)        not null, primary key
#  branch_id  :bigint(8)
#  title      :string           not null
#  begin_date :date             not null
#  end_date   :date             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#


require "test_helper"

class GradeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
