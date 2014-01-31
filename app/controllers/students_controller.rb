class StudentsController < ApplicationController
  def index
    @student = Student.all
  end

  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(params[:student].permit(:fname, :lname, :nname, :email))
    if @student.save
      flash[:notice] = "You have successfully created a student"
      redirect_to students_path      
    else
      render 'new' 
    end
  end
  
  def show
    @student = Student.find(params[:id])
    redirect_to students_path
  end

  def edit
    @student = Student.find(params[:id])

  end

  def update
    @student = Student.find(params[:id])
 
    if @student.update(params[:student].permit(:fname, :lname, :nname, :email))
      flash[:notice] = "You have successfully updated a student"
      redirect_to @student
    else
      render 'edit'
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    flash[:notice] = "You have successfully deleted a student"
    redirect_to students_path
  end
private
  def student_params
    params.require(:student).permit(:fname, :lname, :nname, :email)
  end
end
