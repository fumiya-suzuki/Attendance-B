class AttendanceApproval < ApplicationRecord
  belongs_to :attendance
  belongs_to :approval
end
