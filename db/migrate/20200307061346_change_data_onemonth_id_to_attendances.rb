class ChangeDataOnemonthIdToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :onemonth_id, :integer
  end
end
