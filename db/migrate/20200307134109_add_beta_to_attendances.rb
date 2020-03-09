class AddBetaToAttendances < ActiveRecord::Migration[5.1]
  def change
    add_column :attendances, :beta_started_at, :datetime
    add_column :attendances, :beta_finished_at, :datetime
    add_column :attendances, :beta_note, :string
  end
end
