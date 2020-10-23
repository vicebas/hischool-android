# frozen_string_literal: true

# == Schema Information
#
# Table name: institutions
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  admin_id   :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Institution < ApplicationRecord
  belongs_to :admin
  has_many :branches
  has_many :teachers
end
