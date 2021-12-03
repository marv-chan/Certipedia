class SessionsController < ApplicationController

  def login
    if session[:username] != nil
      @user = User.where(username: session[:username]).first
      redirect_to @user
    end
  end

  def create
    uname = sessions_params[:username]
    pword = sessions_params[:password]
    @user = User.where(username: uname, password: pword)
    if @user.empty?
      flash[:error] = 'Username or password error'
      redirect_to login_url
      return
    end
    if uname == 'admin'
      session[:admin] = true
    end
    session[:username] = uname
    session[:id] = @user.first.id
    redirect_to @user.first
  end

  def logout
    session[:username] = nil
    session[:id] = nil
    session[:admin] = nil
    flash[:notice] = 'You have logged out'
    redirect_to login_url
  end

  private
  def sessions_params
    params.require(:sessions).permit(:username, :password)
  end
end
