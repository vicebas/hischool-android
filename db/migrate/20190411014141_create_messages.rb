# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.references :grade_unit, foreign_key: true
      t.text :text, null: false

      t.timestamps
    end
  end
end
