class UsersController < ApplicationController
   skip_before_action :require_login, only: [:new, :create]

  def show
  #  print(params)
    uname = session[:username]
    @user = User.where(:username => uname).first
    print(@user)
    @courses = User.bookmarked_courses



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

    @user = User.try_login(user_params)
    if @user == false
      @user = User.make_new_user(user_params)
    end

    if @user.valid?
    #  session.clear
    #  print(session[:username])
      session[:username] = @user.username
      flash[:notice] = 'User was created'
      redirect_to @user
    else
      flash[:error] = 'Failed -- please try to create an account again'
      redirect_to new_user_path
    end

  end

  def edit
    @yser = User.find params[:id]
  end


  private

  def user_params
    params.require(:user).permit(:name, :username, :password)
  end



end
