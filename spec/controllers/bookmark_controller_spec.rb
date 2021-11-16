require 'rails_helper'


RSpec.describe BookmarksController, type: :controller do


  describe 'GET new' do
    cert =   Certificate.create(:school => "Cornell University", :name => "NoSQL",
                         :subject => "Computer Science", :website => "http://test.com")


    it 'routes to bookmarks new' do
      expect(:get => "/certificates/12/bookmarks/new" )
      route_to controller: "bookmarks",
      action: "new",
      certificate_id: "12"

    end

    it 'tries to create without being logged in' do
      get(:new, certificate_id: cert.id,username: nil)
      expect(flash[:notice]).to match(/Please login before you attempt to add bookmarks./)
      expect(response).to render_template('index')

    end


    it 'tries to create a bookmark after logging in' do
      user = User.create(:name => "Alexander", :username => "test1",
                   :password => "password1")


      get(:new, certificate_id: cert.id,username: user.username  )
      expect(flash[:notice]).to match(/Bookmark created./)
      expect(response).to render_template('index')
    Certificate.find_by(:school => "Cornell University").destroy
    User.find_by(:name => "Alexander").destroy
  end
  end
end
