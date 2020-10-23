
# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :tax_id
  has_one :student
end
