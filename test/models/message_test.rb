# frozen_string_literal: true

# == Schema Information
#
# Table name: messages
#
#  id            :bigint(8)        not null, primary key
#  grade_unit_id :bigint(8)
#  text          :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#


require "test_helper"

class MessageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
