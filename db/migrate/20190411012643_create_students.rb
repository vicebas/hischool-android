# frozen_string_literal: true

class CreateStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :students do |t|
      t.references :user, foreign_key: true
      t.references :branch, foreign_key: true
      t.string :name, null: false
      t.string :cellphone
      t.date :birthdate
      t.string :tax_id, null: false
      t.string :enrollment_id, null: false

      t.timestamps
    end
  end
end
