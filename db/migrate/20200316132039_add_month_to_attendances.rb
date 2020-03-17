class AddMonthToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :one_month, :date
    add_column :attendances, :over_month, :date
  end
end
