class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  # 出勤時間が存在しない場合、退勤時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 出勤･退勤時間どちらも存在するとき、出勤時間より早い退勤時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  # 出勤･退勤時間どちらも存在するとき、退勤時間のみの削除は不可能
  validate :finished_at_cannot_only_delete
  # 出勤･退勤時間どちらも存在するとき、出勤時間のみの削除は不可能
  validate :started_at_cannot_only_delete
  # 出勤･退勤時間どちらも存在するとき、どちらか片方のみの変更は無効
  validate :started_at_or_finished_at_only_change_is_invalid
  
  validate :superior_user_cannot_approval_own
  
  validate :superior_user_cannot_approval_own_onemonth
  
  
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at, "より早い退勤時間は無効です") if started_at > finished_at
    end
  end
  
  def finished_at_cannot_only_delete
    if started_at_was.present? && finished_at_was.present?
     errors.add(:finshed_at, "のみの削除は出来ません") unless (started_at.nil? && finished_at.nil?) || (started_at.present? && finished_at.present?)
    end  
  end
  
  def started_at_cannot_only_delete
    if started_at_was.present? || finished_at_was.present?
     errors.add(:started_at, "のみの削除は出来ません") unless (started_at.nil? && finished_at.nil?) || (started_at.present? && finished_at.present?)
    end  
  end


  def started_at_or_finished_at_only_change_is_invalid
    if started_at_was.present? && finished_at_was.present?
      if (started_at_was == started_at) && (finished_at_was != finished_at)
        errors.add(:finshed_at, "のみの更新は出来ません") 
      elsif (started_at_was != started_at) && (finished_at_was == finished_at)
        errors.add(:started_at, "のみの更新は出来ません") 
      end
    end
  end
  
  def superior_user_cannot_approval_own
      errors.add(:over_id, "自分以外の上長ユーザを選択してください") if over_id == user_id
  end
  
    def superior_user_cannot_approval_own_onemonth
      errors.add(:onemonth_id, "自分以外の上長ユーザを選択してください") if onemonth_id == user_id
    end
end