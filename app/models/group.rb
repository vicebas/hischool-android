# frozen_string_literal: true

class Group < ApplicationRecord
  belongs_to :unit
  has_many :grade_units

  validates :code, uniqueness: { scope: :unit }
end
