class AddApprovalChangeToApprovals < ActiveRecord::Migration[5.1]
  def change
    add_column :approvals, :approval_change, :boolean
  end
end
