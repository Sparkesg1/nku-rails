class AssignmentsController < ApplicationController
  def show
    redirect_to assignments_path
  end
  
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
        @average = Assignment.average_percentage(params[:student_id])
      end
      
    else
      @assignments = @current_student.assignments
      @average = Assignment.average_percentage(@current_student.id)
    end
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
    current_user = current_user
    if( !current_user || !current_user.is_admin? )
      redirect_to students_path, notice: "Unauthorized!"
    end
    
    @assignment = Assignment.new(assignment_params)
    if @assignment.save

    else
      render 'new'
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
    params.require(:assignment).permit(:id, :assignment_name, :score, :total, :student_id, :nick_name)
  end
  
end