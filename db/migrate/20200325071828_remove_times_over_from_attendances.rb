class RemoveTimesOverFromAttendances < ActiveRecord::Migration[5.1]
  def change
    remove_column :attendances, :scheduled_end_time, :timestamp
  end
end
