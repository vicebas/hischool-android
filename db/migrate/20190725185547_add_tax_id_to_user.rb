class AddTaxIdToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tax_id, :string
    remove_column :students, :tax_id
    remove_column :teachers, :tax_id
  end
end
