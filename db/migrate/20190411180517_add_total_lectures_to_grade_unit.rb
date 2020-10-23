# frozen_string_literal: true

class AddTotalLecturesToGradeUnit < ActiveRecord::Migration[5.2]
  def change
    add_column :grade_units, :total_lectures, :integer
  end
end
