class BookmarksController < ApplicationController

  def new
  #  print(params)
    cert_id = params[:certificate_id]
    @certificate = Certificate.find cert_id
    uname = session[:username]
    @user = User.get_user(uname)
    if @user == false
      flash[:notice] = "Please login before you attempt to add bookmarks."
      redirect_to certificates_path
      return
    else
      flash[:notice] = "Added bookmark for course #{@certificate.name} !"
    end
    #add bookmark here

    #this call does not work for some reason
    @bookmark = Bookmark.add_bookmark(@certificate,@user)

    redirect_to certificates_path
  end


end
