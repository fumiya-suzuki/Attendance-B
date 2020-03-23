require 'csv'
CSV.generate do |csv|
  csv << ["勤怠情報"]
  csv << []
  column_names = %w(日付 出社時間 退社時間 備考)
  csv << column_names
  @attendance.each do |attendance|
    column_values = [
     if attendance.worked_on.present?
      attendance.worked_on.strftime("%m/%d")
     end,
     if attendance.started_at.present?
      attendance.started_at.strftime("%H:%M")
     end,
     if attendance.finished_at.present?
      attendance.finished_at.strftime("%H:%M") 
     end,
      attendance.note
    ]
    csv << column_values  
  end
end