# frozen_string_literal: true

class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.decimal :lat, precision: 9, scale: 7
      t.decimal :lng, precision: 9, scale: 7
      t.references :institution, foreign_key: true
      t.string :cep, null: false
      t.string :neighborhood, null: false
      t.string :federation_id, null: false
      t.string :complement
      t.string :city, null: false
      t.string :street, null: false
      t.string :address_number, null: false
      t.string :telephone

      t.timestamps
    end
  end
end
