# frozen_string_literal: true

# == Schema Information
#
# Table name: student_dashboards
#
#  id                           :bigint(8)        not null, primary key
#  student_id                   :bigint(8)
#  cached_last_presence         :date
#  cached_attendance_percentage :integer
#  cached_chat_messages         :integer
#  cached_total_groups          :integer
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#

require "test_helper"

class StudentDashboardTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
