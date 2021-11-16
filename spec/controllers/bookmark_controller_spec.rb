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

      get(:new, certificate_id: cert.id,username: nil)
      expect(flash[:notice]).to match(/Please login before you attempt to add bookmarks./)
      expect(response).to redirect_to(certificates_path)
      Certificate.find_by(:school => "Cornell University").destroy

    end


    it 'tries to create a bookmark after logging in' do
      cert =   Certificate.create(:school => "Cornell University", :name => "NoSQL",
                           :subject => "Computer Science", :website => "http://test.com")
      user = User.create(:name => "Alexander", :username => "bookmark_user",
                   :password => "password1")


      get(:new, certificate_id: cert.id,username: user.username  )
      expect(flash[:notice]).to match(/Added bookmark for course #{cert.name} !/)
      expect(response).to render_template('index')
      Certificate.find_by(:school => "Cornell University").destroy


  end
  end

end
