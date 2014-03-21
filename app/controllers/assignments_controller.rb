class AssignmentsController < ApplicationController
  def new
    # Allows admins to create new assignments
    @current_student = get_current_student
    if( !@current_student.is_admin? )
      redirect_to students_path, notice: "Unauthorized!"
    end
    
    @assignment = Assignment.new
    @students = Student.all
  end
  
  def create
    @assignment = Assignment.new
    
    #get the student ID of the student typed in the field, match by name
    @selected_student = Student.find_by_name(params[:student])
    
    @assignment.student = @selected_student
    @assignment.name = params[:assignment][:name]
    @assignment.score = params[:assignment][:score]
    @assignment.total = params[:assignment][:total]
    
    @assignment.save
    redirect_to assignments_path, :notice => "You have successfully created this assignment."
  end
  
  def show
    @assignments = Assignments.where("student_id = ?", params[:id])
  end
  
  def index
    @students = Student.all

    if( @current_user.is_admin? )
      # Admin can see all
      if( params[:student_id] )
        # Fetch this student's assignments
        @selected_student = Student.find(params[:student_id])
        @assignments = @selected_student.assignments
      else
        # Fetch all assignments
        @assignments = Assignment.all
      end
    end
  end
end