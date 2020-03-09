class RemoveOnemonthApprovalFromAttendances < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :integer, :string
  end
end
