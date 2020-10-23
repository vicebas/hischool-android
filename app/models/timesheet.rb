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
#

class Timesheet < ApplicationRecord
  belongs_to :grade_unit
  belongs_to :student
end
