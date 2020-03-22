class CreateAttendanceApprovals < ActiveRecord::Migration[5.1]
  def change
    create_table :attendance_approvals do |t|
      t.integer :attendance_id
      t.integer :approval_id

      t.timestamps
    end
  end
end
