class AddOvertimeToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :scheduled_end_time, :time
    add_column :attendances, :occupation, :string
    add_column :attendances, :superior_confirmation, :boolean
  end
end
