class SessionsController < ApplicationController
  # before_action :require_logged_in
  before_action :already_logged_in, only: [:new, :create]

  
  def new
    @user = User.new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])
    if @user 
      login(@user)
      redirect_to cats_url
    else 
      flash[:errors] = ['invalid username or password'] 
      redirect_to new_session_url
    end
  end
  
  def destroy
    return nil unless current_user
    logout
    redirect_to cats_url
  end
  
end
