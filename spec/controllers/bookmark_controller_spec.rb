require 'rails_helper'


RSpec.describe BookmarksController, type: :controller do


  describe 'GET new' do



    it 'routes to bookmarks new' do
      expect(:get => "/certificates/1/bookmarks/new" )
      route_to controller: "bookmarks",
      action: "new",
      certificate_id: "1"

    end

    it 'tries to create without being logged in' do
      cert =   Certificate.create(:school => "Cornell University", :name => "NoSQL",
                           :subject => "Computer Science", :website => "http://test.com")

      get :create  #call with no session username
      expect(response).to redirect_to(login_url)
      Certificate.find_by(:school => "Cornell University").destroy

    end


    it 'tries to create a bookmark after logging in' do
      cert =   Certificate.create(:school => "Cornell University", :name => "NoSQL",
                           :subject => "Computer Science", :website => "http://test.com")
      user = User.create(:name => "Alexander", :username => "bookmark_user",
                   :password => "password1")


      get :create, {bookmarks: {certificate_id: cert.id}},{username: user.username}
      expect(flash[:notice]).to match(/Added bookmark for course #{cert.name}!/)
      expect(response).to redirect_to(certificate_path(cert.id))

      Certificate.find_by(:school => "Cornell University").destroy
      Bookmark.find_by(:certificate_id => cert.id).destroy
      User.find_by(:username => user.username).destroy


    end
  end

end
