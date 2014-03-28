class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
   before_action :require_login
  def current_user
    @current_user ||= Student.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
    private
 
  def require_login
    if current_user == nil
      flash[:error] = "You must be logged"
      redirect_to sessions_path
    end
  end
end
