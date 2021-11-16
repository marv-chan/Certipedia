class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    if session[:username] != nil
      @user = User.where(username: uname)
      redirect_to users_path
    end
  end

  def create
    uname = sessions_params[:username]
    pword = sessions_params[:password]
    @user = User.where(username: uname, password: pword)
    print(@user.empty?)
    if @user.empty?
      flash[:notice] = 'Username or password error'
      redirect_to new_session_path
      return
    end
    session[:username] = uname
    redirect_to users_path
  end

  private
  def sessions_params
    params.require(:sessions).permit(:username, :password)
  end
end
