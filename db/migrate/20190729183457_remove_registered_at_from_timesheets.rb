class RemoveRegisteredAtFromTimesheets < ActiveRecord::Migration[5.2]
  def change
    remove_column :timesheets, :registered_at
  end
end
