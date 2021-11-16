class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def require_login
    @uname = session[:username]
    if @uname == nil
      redirect_to new_user_path
    end
    #redirect_to new_user_path unless session.include? :username
  end
end
