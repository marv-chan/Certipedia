class BookmarksController < ApplicationController

  def new
    cert_id = params[:certificate_id]
    uname = session[:username]
    @certificate = Certificate.find cert_id
    @user = User.where(username: uname)
    if @user.empty?
      redirect_to new_session_path
      return
    end
    @user = @user.first
    @bookmark = Bookmark.where(user_id: @user.id, certificate_id: @certificate)
    if @bookmark.empty?
      flash[:notice] = "Added bookmark for course #{@certificate.name}!"
      @bookmark = Bookmark.add_bookmark(@user, @certificate)
    end
    
    redirect_to @certificate

    # cert_id = params[:certificate_id]
    # print(params)
    # @certificate = Certificate.find cert_id
    # uname = session[:username]
    # @user = User.get_user(uname)
    # if @user == false
    #   flash[:notice] = "Please login before you attempt to add bookmarks."
    #   redirect_to certificates_path
    #   return
    # else
    #   @bookmark = Bookmark.create!(:user => @user, :certificate => @certificate)
    #   flash[:notice] = "Added bookmark for course #{@certificate.name} !"
    #   redirect_to certificates_path
    # end
    # #add bookmark here
    # #this call does not work for some reason
    # # @bookmark = Bookmark.add_bookmark(@certificate,@user)
    # redirect_to certificates_path
  end

end
