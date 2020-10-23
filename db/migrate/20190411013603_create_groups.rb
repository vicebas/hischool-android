class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.references :unit, foreign_key: true, null: false
      t.string :code

      t.timestamps
    end
  end
end
