# frozen_string_literal: true

class CreateTimesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :timesheets do |t|
      t.references :grade_unit, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
