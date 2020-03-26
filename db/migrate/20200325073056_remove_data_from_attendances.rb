class RemoveDataFromAttendances < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :scheduled_end_time, :datetime
  end
end
