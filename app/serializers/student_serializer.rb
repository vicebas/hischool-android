# frozen_string_literal: true

class StudentSerializer < ActiveModel::Serializer
  attributes :name, :birthdate, :email

  [:cellphone].each do |attr|
    attribute attr
    define_method attr do
      object.send(attr).to_s
    end
  end

  def name
    object.name.titleize
  end

  def birthdate
    object.birthdate ? I18n.localize(object.birthdate, format: :descriptive_datetime) : ""
  end
end
