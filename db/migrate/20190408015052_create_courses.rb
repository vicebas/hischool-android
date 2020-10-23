# frozen_string_literal: true

class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.references :branch, foreign_key: true
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps
    end
  end
end
