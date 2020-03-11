class AddNextdayToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :over_next_day, :boolean, default: false
    add_column :attendances, :one_next_day, :boolean, default: false
  end
end
