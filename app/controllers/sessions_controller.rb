class SessionsController < ApplicationController

  def new
    if session[:username] != nil
      print(session[:username])
      @user = User.where(username: session[:username]).first
      redirect_to @user
    end
  end

  def create
    uname = sessions_params[:username]
    pword = sessions_params[:password]
    @user = User.where(username: uname, password: pword)
    print(@user)
    print(@user.empty?)
    if @user.empty?
      flash[:error] = 'Username or password error'
      redirect_to new_session_path
      return
    end
    session[:username] = uname
    redirect_to @user.first
  end

  private
  def sessions_params
    params.require(:sessions).permit(:username, :password)
  end
end
