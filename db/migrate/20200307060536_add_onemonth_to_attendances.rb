class AddOnemonthToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :onemonth_confirm, :integer
  end
end
