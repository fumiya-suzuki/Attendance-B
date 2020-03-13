
require 'csv'

CSV.generate do |csv|
  csv_column_names = %w(name email affiliation employee_number uid basic_work_time designnated_work_start_time designated_work_end_time superior admin password)
  csv << csv_column_names
  @users.each do |user|
    csv_column_values = [
      user.name,
      user.email,
      user.department,
      user.employee_number,
      user.uid,
      user.basic_time,
      user.basic_start_time,
      user.basic_leave_time,
      user.superior,
      user.admin,
      user.password
    ]
    csv << csv_column_values
  end
end