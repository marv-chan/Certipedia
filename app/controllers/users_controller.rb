class UsersController < ApplicationController
   skip_before_action :require_login, only: [:new, :create]

  def show
    uname = session[:username]


    @user = User.find(params[:id])

    #print(:session)
    if @user.username != uname
      flash[:notice] = 'You do not have permission to view this page'
      redirect_to new_session_path
      return
    end
    @certificates =  User.bookmarked_courses(@user)

  end

  def index
    redirect_to new_user_path
  end

  def first_page

  end

  def new
    #hope just the default

  end

  def create
    @user = User.where(username: user_params[:username])
    if @user.empty?
      @user = User.make_new_user(user_params)
      flash[:notice] = 'User was created'
      session[:username] = @user.username
      redirect_to new_session_path
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
