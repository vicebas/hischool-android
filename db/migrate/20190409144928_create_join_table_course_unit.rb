# frozen_string_literal: true

class CreateJoinTableCourseUnit < ActiveRecord::Migration[5.2]
  def change
    create_join_table :courses, :units do |t|
      t.index [:course_id, :unit_id]
      t.index [:unit_id, :course_id]
    end
  end
end
