class Attendance < ActiveRecord::Base
  belongs_to :student
  validates :student_id, uniqueness: { scope: :attended_on, message: "Can only attend one class per day"}
  validates :seat, :numericality => {:only_integer => true}
  validates :seat, :inclusion => 1..4

end