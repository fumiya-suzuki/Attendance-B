class AddNowToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :now_month, :date
  end
end
