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


class Grade < ApplicationRecord
  belongs_to :branch
  has_many :grade_units

  # Pagination settings
  paginates_per 10
end
