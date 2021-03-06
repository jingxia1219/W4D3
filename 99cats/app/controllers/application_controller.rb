class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  
  
  def login(user)
    @current_user = user
    session[:session_token] = user.reset_session_token!
  end
  
  def logout
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_logged_in
    redirect_to new_user_url unless logged_in?
  end 

  def already_logged_in
    redirect_to cats_url if logged_in? 
  end 
    
end
