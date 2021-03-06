module AttendancesHelper
  
  def attendance_state(attendance)
    # 受け取ったAttendanceオブジェクトが当日と一致するか評価します。
    if Date.current == attendance.worked_on
      return '出勤' if attendance.started_at.nil?
      return '退勤' if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # どれにも当てはまらなかった場合はfalseを返します。
    return false
  end
  
  def working_times(start, finish)
    format("%.2f", (((finish - start) / 60) / 60.0))
  end
  
  def out_times(start, finish, startmin, finishmin)
    format("%.2f", ((finish - start)) + ((finish - start) / 60))
  end
  
  def next_out_times(start, finish, startmin, finishmin)
    format("%.2f", (((finish - start)) + ((finishmin - startmin) / 60) + 24))
  end
  
  def over_times(start, finish)
    format("%.2f", ((((finish - start) / 60) / 60.0) + 24.0))
  end
  
end
