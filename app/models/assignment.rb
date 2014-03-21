class Assignment < ActiveRecord::Base
  belongs_to :student
  
  def percentage
    ((score / total.to_f) * 100).round
  end
  
  def self.average_percentage(student_id=nil)
    totals = 0
    scores = 0
    Assignment.all.each do |assignment|
      scores = scores + assignment.score
      totals = totals + assignment.total
      
    end
    (average_percentage = (scores.to_f / totals) *100).round
  end
end