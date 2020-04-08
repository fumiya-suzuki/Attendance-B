require 'csv'
CSV.generate do |csv|
  csv << ["勤怠情報"]
  csv << []
  column_names = %w(日付 出社時間 退社時間 備考)
  csv << column_names
  @attendance.each do |attendance|
    if attendance.onemonth_confirm == 2
    column_values = [
     if attendance.worked_on.present?
      attendance.worked_on.strftime("%m/%d")
     end,
     if attendance.beta_started_at.present?
      attendance.beta_started_at.floor_to(15.minutes).strftime("%H:%M")
     end,
     if attendance.beta_finished_at.present?
      attendance.beta_finished_at.floor_to(15.minutes).strftime("%H:%M")
     end,
     attendance.beta_note
    ]
    else
    column_values = [
     if attendance.worked_on.present?
      attendance.worked_on.strftime("%m/%d")
     end,
     if attendance.started_at.present?
      attendance.started_at.floor_to(15.minutes).strftime("%H:%M")
     end,
     if attendance.finished_at.present?
      attendance.finished_at.floor_to(15.minutes).strftime("%H:%M")
     end,
     attendance.note
    ]
    end
    csv << column_values  
  end
end