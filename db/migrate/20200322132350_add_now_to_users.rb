class AddNowToUsers < ActiveRecord::Migration[5.1]
  def up
    add_column :users, :now_month, :date
  end
  
  def down
    ActiveRecord::IrreversibleMigration
  end
end
