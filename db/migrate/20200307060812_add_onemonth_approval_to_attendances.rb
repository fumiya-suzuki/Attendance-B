class AddOnemonthApprovalToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :onemonth_id, :integer
  end
end
