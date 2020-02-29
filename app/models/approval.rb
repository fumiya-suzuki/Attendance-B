class Approval < ApplicationRecord
  belongs_to :user
  
    validates :user_id, presence: true
    validates :superior_id, presence: true
    validates :month, uniqueness: {scope: :user_id}
    
    validate :superior_user_cannot_approval_own
    
    
    def superior_user_cannot_approval_own
      errors.add(:superior_id, "自分以外の上長ユーザを選択してください") if superior_id == user_id
    end
end
