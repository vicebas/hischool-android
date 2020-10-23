# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           not null
#  encrypted_password     :string           not null
#  tokens                 :json
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable
  include DeviseTokenAuth::Concerns::User

  has_one :student
  has_one :teacher
  validates :email, :tax_id, uniqueness: true
  validates :email, :tax_id, presence: true

  def tokens_has_json_column_type?
    false
  end

  def profile
    student || teacher
  end
end
