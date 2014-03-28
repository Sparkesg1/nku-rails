class AssignmentUploader
 
  def self.upload_file(file)
    CSV.foreach(file.path, :headers => true) do |record|
     
      upload_assignment(record)
      
    end
    
  end
  
  def self.upload_assignment(assignment_array)
    student_id = assignment_array['student_id']
    name = assignment_array['assignment_name']
    
    student = Student.find(student_id)
    assignments = Assignment.where("student_id = ? AND name = ?", student.id, name)
    if assignments.size == 0
      assignment = Assignment.new
      assignment.student = student
      assignment.name = name
    else
      assignment = assignments[0]
    end
    
    assignment.total = assignment_array['total']
    assignment.score = assignment_array['score']
    assignment.save!
    
  end
  
end