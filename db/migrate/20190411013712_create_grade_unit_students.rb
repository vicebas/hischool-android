# frozen_string_literal: true

class CreateGradeUnitStudents < ActiveRecord::Migration[5.2]
  def change
    create_table :grade_unit_students do |t|
      t.references :grade_unit, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
