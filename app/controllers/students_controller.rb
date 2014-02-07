class StudentsController < ApplicationController
  def index
    @student = Student.all
  end

  def new
    @student = Student.new
  end
  
  def create
    @student = Student.new(params[:student].permit(student_params))
    if @student.save
      session[:user_id] = @student.id
      redirect_to students_path, :notice => "You have signed up."
    else
      flash[:notice] = "You did not provide identical password"
      render 'new'
    end
  end
  
  def show
    @student = Student.find(params[:id])
    @current = current_user
    redirect_to students_path
  end

  def edit
    @student = Student.find(params[:id])

  end

  def update
    @student = Student.find(params[:id])
 
    if @student.update(params[:student].permit(student_params))
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
    
    session[:user_id] = nil
    @current_user = nil
    redirect_to students_path
  end
private
  def student_params
    params.require(:student).permit(:first_name, :last_name, :nick_name, :email, :password, :password_confirmation)
  end
end
