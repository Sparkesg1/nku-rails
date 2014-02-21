class Attendance < ActiveRecord::Base
  belongs_to :student
  validates :student_id, uniqueness: { scope: :attended_on, message: "Can only attend one class per day"}
  validates :seat, :numericality => {:only_integer => true, message: "Must be a whole number"}
  validates :seat, :inclusion => 1..4
  validates :seat, uniqueness: { scope: :attended_on, message: "Only 1 person can occupy 1 seat per day" }

end