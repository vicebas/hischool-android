# frozen_string_literal: true

class CreateUnits < ActiveRecord::Migration[5.2]
  def change
    create_table :units do |t|
      t.references :course, foreign_key: true
      t.references :branch, foreign_key: true
      t.string :name, null: false
      t.string :code, null: false
      t.integer :kind, null: false, default: 0

      t.timestamps
    end
  end
end
