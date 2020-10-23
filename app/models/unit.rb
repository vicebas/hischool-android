# frozen_string_literal: true

# == Schema Information
#
# Table name: units
#
#  id         :bigint(8)        not null, primary key
#  course_id  :bigint(8)
#  branch_id  :bigint(8)
#  name       :string           not null
#  code       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Unit < ApplicationRecord
  belongs_to :course
  belongs_to :branch
  has_many :grade_units
  has_many :groups
  enum kind: [ :theoretic, :practical ]
end
