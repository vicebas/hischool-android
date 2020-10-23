# frozen_string_literal: true

class CreateInstitutions < ActiveRecord::Migration[5.2]
  def change
    create_table :institutions do |t|
      t.string :name, null: false
      t.references :admin, foreign_key: true

      t.timestamps
    end
  end
end
