class Approval < ApplicationRecord
  belongs_to :user
  
    validates :user_id, presence: true
    validates :superior_id, presence: true
end
