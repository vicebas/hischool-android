# frozen_string_literal: true

# == Schema Information
#
# Table name: courses
#
#  id         :bigint(8)        not null, primary key
#  branch_id  :bigint(8)
#  code       :string           not null
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Course < ApplicationRecord
  belongs_to :branch
  has_many :units

  # Pagination settings
  paginates_per 25
end
