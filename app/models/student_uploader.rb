class StudentUploader
  
  def self.upload_file(file)
    CSV.foreach(file.path, :headers => true) do |record|
      upload_student(record)      
    end
  end
  
  def self.upload_student(student_array)
    student = Student.new
    student.email = student_array['email']
    student.first_name = student_array['first_name']
    student.first_name = student_array['last_name']
    student.nick_name = student_array['nick_name']
    student.password = student_array['password']
    student.password_confirmation = student_array['password']
    student.save!
  end
end