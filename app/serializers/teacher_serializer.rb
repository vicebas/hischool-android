# frozen_string_literal: true

class TeacherSerializer < ActiveModel::Serializer
  attributes :id, :name, :email,  :cellphone, :tax_id, :birthdate
end
