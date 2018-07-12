class UsersController < ApplicationController
  before_action :already_logged_in, only: [:new, :create]
  def index
    @users = User.all
    render :index 
  end
  
  def new
    # redirect_to cats_url if logged_in?
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login(@user)
      redirect_to cats_url
    else
      redirect_to new_user_url
    end
  end
  
  def show
    @user = User.find(params[:id])
    if @user
      redirect_to user_url(@user)
    else
      redirect_to new_user_url
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end
  

end
