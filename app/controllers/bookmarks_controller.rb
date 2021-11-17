class BookmarksController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    @user = User.where(username: session[:username])
    if @user.empty?
      redirect_to new_session_path
      return
    end
    @user = @user.first
    cert_id = params[:bookmarks][:certificate_id]
    @certificate = Certificate.find cert_id
    @bookmark = Bookmark.where(user_id: @user.id, certificate_id: @certificate.id)
    if @bookmark.empty?
      flash[:notice] = "Added bookmark for course #{@certificate.name}!"
      @bookmark = Bookmark.add_bookmark(@user, @certificate)
    end
    
    redirect_to @certificate
  end

end
