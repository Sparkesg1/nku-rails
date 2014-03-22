class Assignment < ActiveRecord::Base
  belongs_to :student
  
  def percentage
    ((score / total.to_f) * 100).round
  end
  
  def self.average_percentage(student_id=nil)

    if( student_id )
      assignments = Student.find(student_id).assignments
    else
      assignments = all
    end

    percentage_sum = 0
    assignments.each{ |a| percentage_sum += a.percentage }
    if(assignments.size != 0)
      percentage_sum / assignments.size
    else
      return 0
    end
    
  end
end