class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_login
    @uname = session[:username]
    print(uname)
    print("testing require login")
    if @uname != 'none'
      redirect_to new_user_path
    end
    #redirect_to new_user_path unless session.include? :username
  end
end
