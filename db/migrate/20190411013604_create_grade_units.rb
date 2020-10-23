# frozen_string_literal: true

class CreateGradeUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :grade_units do |t|
      t.references :grade, foreign_key: true, null: false
      t.references :unit, foreign_key: true, null: false
      t.references :group, foreign_key: true, null: false
      t.datetime :starts_on, null: false
      t.datetime :ends_on, null: false
      t.timestamps
    end
  end
end
