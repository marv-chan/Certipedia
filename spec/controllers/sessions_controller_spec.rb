require 'rails_helper'

RSpec.describe SessionsController, type: :controller do

  describe 'GET new' do
    it 'redirects to user view' do
      user = User.create(:name => "Alexander", :username => "sessions_user",
                   :password => "password1")

      get :new, nil,{username: user.username}
      expect(response).to redirect_to(user)
      User.find_by(:username => user.username).destroy
    end
  end

  describe "GET create" do

    it 'redirects to new session path if invalid username or password' do

      get :create, sessions: {username: nil,password:nil}
      expect(flash[:error]).to match(/Username or password error/)
      expect(response).to redirect_to(new_session_path)
    end

    it 'redirects to user if sucessfull' do
      user = User.create(:name => "Alexander", :username => "sessions_user",
                   :password => "password1")
      get :create, sessions: {username: user.username,password:user.password}
      expect(response).to redirect_to(user)
      User.find_by(:username => user.username).destroy
    end
  end

end
