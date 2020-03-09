class AddOnemonthApprovalToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :onemonth_id, :string
    add_column :attendances, :integer, :string
  end
end
