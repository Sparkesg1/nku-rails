class AttendancesController < ApplicationController
  def index
    if( params[:student_id] )      
      @selected_student = Student.find( params[:student_id] )
      @attendances = Attendance.where( student: @selected_student )
    else
      @attendances = Attendance.all
    end
  end
  
  def new
    @attendance = Attendance.new
  end
  
  def create
    @current = current_user

    if !@current
      redirect_to sessions_path
    end
    
    @attendance = Attendance.new
    @attendance.seat = params[:attendance][:seat]
    @attendance.attended_on = Time.now 
    @attendance.student_id = @current.id
    @attendance.save
        
    if @attendance.save
      redirect_to attendances_path, :notice => "You have successfully logged your attendance."
    else
      render "new"
    end
  end
  def show
    @attendances = Attendance.where("student_id = ?", params[:id])
  end
end