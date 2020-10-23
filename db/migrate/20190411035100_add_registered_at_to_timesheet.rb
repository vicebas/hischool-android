# frozen_string_literal: true

class AddRegisteredAtToTimesheet < ActiveRecord::Migration[5.2]
  def change
    add_column :timesheets, :registered_at, :datetime
  end
end
