# frozen_string_literal: true

class DeviseCreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email, null: false
      t.string :encrypted_password, null: false
      ## Devise Token Auth
      t.json :tokens
      t.string :provider, null: false, default: "email"
      t.string :uid, null: false, default: ""
      ## Recoverable
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      ## Trackable
      t.integer  :sign_in_count, default: 0, null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.inet :current_sign_in_ip
      t.inet :last_sign_in_ip
      ## Default timestamps
      t.timestamps null: false
    end

    add_index :users, [:email], unique: true
    add_index :users, [:uid, :provider], unique: true
    add_index :users, :reset_password_token, unique: true
  end
end
