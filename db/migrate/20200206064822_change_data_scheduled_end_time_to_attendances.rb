class ChangeDataScheduledEndTimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    change_column :attendances, :scheduled_end_time, :datetime
  end
end
