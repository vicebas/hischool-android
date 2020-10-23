# frozen_string_literal: true

class CreateGradeUnitTeachers < ActiveRecord::Migration[5.2]
  def change
    create_table :grade_unit_teachers do |t|
      t.references :grade_unit, foreign_key: true
      t.references :teacher, foreign_key: true
      t.datetime :teacher_clock_in
      t.timestamps
    end
  end
end
