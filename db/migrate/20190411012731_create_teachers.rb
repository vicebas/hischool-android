# frozen_string_literal: true

class CreateTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :teachers do |t|
      t.references :user, foreign_key: true
      t.references :institution, foreign_key: true
      t.string :name, null: false
      t.string :cellphone
      t.date :birthdate
      t.string :tax_id, null: false

      t.timestamps
    end
  end
end
