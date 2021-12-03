class UsersController < ApplicationController
   skip_before_action :require_login, only: [:new, :create]

  def show
    uname = session[:username]
    @user = User.find(params[:id])

    if @user.username != uname
      flash[:notice] = 'You do not have permission to view this page'
      redirect_to login_url
      return
    end
    @certificates =  @user.certificates
  end

  def index
    redirect_to new_user_path
  end

  def first_page

  end

  def new

  end

  def create
    @user = User.where(username: user_params[:username])
    if @user.empty?
      @user = User.make_new_user(user_params)
      flash[:notice] = 'User was created'
      redirect_to login_url
    else
      flash[:notice] = 'Username already exists'
      redirect_to new_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :username, :password)
  end

end
