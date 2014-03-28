class AssignmentsController < ApplicationController
  
  def index
    @current_student = current_user
    @students = Student.all

    if( @current_student.is_admin? )
      if( params[:student_id] )
        @selected_student = Student.find(params[:student_id])
        @assignments = @selected_student.assignments
        @average = Assignment.average_percentage(params[:student_id])
      else
        @assignments = Assignment.all
        @average = Assignment.average_percentage
      end
      
    else
      @selected_student = @current_student
      @assignments = @current_student.assignments
      @average = Assignment.average_percentage(@selected_student.id)
    end
    
  end

  def show
    redirect_to assignments_path
  end
  
  def new
    @current_student = current_user
    if( !@current_student.is_admin? )
      redirect_to students_path, notice: "Unauthorized!"
    end    
    @assignment = Assignment.new
    @students = Student.all    
  end
  
  def create
    current_student = current_user
    if( !current_student || !current_student.is_admin? )
      redirect_to students_path, notice: "Unauthorized!"
    end
    
    @assignment = Assignment.new(assignment_params)
    if @assignment.save   
      redirect_to assignments_path, notice: "Assignment successfully recorded!"
    else
      render 'new'
    end
  end
  
  def upload
    @current_student = current_user
    if( !@current_student.is_admin? )
      redirect_to assignments_path, notice: "Unauthorized!"
    end
  end
  
  def process_upload
    @current_student = current_user
    if( !@current_student.is_admin? )
      redirect_to assignments_path, notice: "Unauthorized!"
    end
    
    require 'csv'
    file = params[:csv]
    before_count = Assignment.all.size
    AssignmentUploader.upload_file(file)
    after_count = Assignment.all.size
    
    redirect_to assignments_path, notice: "#{after_count - before_count} assignments created."
  end
  
  private
  def assignment_params
    params.require(:assignment).permit(:student_id, :assignment_name, :score, :total)
  end
  
end