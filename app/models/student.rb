# frozen_string_literal: true

# == Schema Information
#
# Table name: students
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  branch_id  :bigint(8)
#  name       :string           not null
#  cellphone  :string
#  birthdate  :date
#  tax_id     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Student < ApplicationRecord
  belongs_to :user
  belongs_to :branch

  # Pagination settings
  paginates_per 25

  has_many :grade_unit_students
  has_many :grade_units, through: :grade_unit_students
  has_many :timesheets, through: :grade_units

  delegate :email, :tax_id, to: :user

  accepts_nested_attributes_for :user
end
