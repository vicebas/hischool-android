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

require "test_helper"

class StudentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
