class Student < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :attendances
  def self.in_seat(seat, date)
     Student.joins(:attendances).where(attendances: {seat: seat, attended_on: date})
  end

  def self.absent(date)
    attendances = Attendance.where(date)
    students = attendances.collect{ |a| a.student_id }
    Student.where.not(id: students)
  end
end