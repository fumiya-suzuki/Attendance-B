class RemoveOvertimeFromAttendances < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :scheduled_end_time, :time
  end
end
