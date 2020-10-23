# frozen_string_literal: true

# == Schema Information
#
# Table name: branches
#
#  id             :bigint(8)        not null, primary key
#  name           :string           not null
#  code           :string           not null
#  lat            :decimal(9, 7)
#  long           :decimal(9, 7)
#  institution_id :bigint(8)
#  cep            :string           not null
#  neighborhood   :string           not null
#  federation_id  :string           not null
#  complement     :string
#  city           :string           not null
#  street         :string           not null
#  address_number :string           not null
#  telephone      :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Branch < ApplicationRecord
  belongs_to :institution
  has_many :courses
  has_many :units
  has_many :grades
  has_many :students

  before_save :get_geolocation

  def get_geolocation
    geolocation = Geokit::Geocoders::GoogleGeocoder.geocode("#{street}, #{address_number}, #{city}, #{federation_id}")
    self.lat = geolocation.lat
    self.lng = geolocation.lng
  end
end
