class RemoveOvertimeToAttendances < ActiveRecord::Migration[5.1]
  def up
    remove_column :attendances, :scheduled_end_time, :time
  end
  
end
