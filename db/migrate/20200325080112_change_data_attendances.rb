class ChangeDataAttendances < ActiveRecord::Migration[5.1]
  def up
    if Rails.env.development? || Rails.env.test?
      add_column :attendances, :scheduled_end_time, :datetime
    else
      add_column :attendances, :scheduled_end_time, 'datetime USING CAST(scheduled_end_time AS datetime)'
    end
  end
  
  def down
    remove_column :attendances, :scheduled_end_time, :time
  end
end
