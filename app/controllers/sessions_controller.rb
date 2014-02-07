class SessionsController < ApplicationController
  def new
  end
  
  def create
    student = Student.find_by_email(params[:email])
    if student && student.authenticate(params[:password])
      session[:user_id] = student.id
      redirect_to students_path, :notice => "Logging in!"
    else
      flash[:notice] = "You need to provide a valid Email/Password"
      redirect_to sessions_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to students_path, :notice => "Logged out!"
  end
end
