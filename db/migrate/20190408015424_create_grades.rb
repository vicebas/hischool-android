# frozen_string_literal: true

class CreateGrades < ActiveRecord::Migration[5.2]
  def change
    create_table :grades do |t|
      t.references :branch, foreign_key: true
      t.string :title, null: false
      t.date :begin_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end
  end
end
