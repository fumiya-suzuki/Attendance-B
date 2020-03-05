class AddOversuperiorToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :over_id, :integer
    add_column :attendances, :over_confirm, :integer, default: 0
  end
end
