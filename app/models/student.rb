class Student < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  has_many :attendances
  def self.in_seat(seat, date)
    Student.joins(:attendances).where(attendances: {seat: seat, attended_on: date})
  end

  def self.absent(date)
    Student.joins(:attendances).where.not(attendances: {attended_on: date})
  end
end