require 'rails_helper'

RSpec.describe SessionsController, type: :controller do



  describe "GET create" do

    it 'redirects to new session path if invalid username or password' do
      get :create, sessions: {username: nil,password:nil}
      expect(flash[:error]).to match(/Username or password error/)
      expect(response).to redirect_to(login_url)
    end

    it 'redirects to user if sucessfull' do
      user = User.create(:name => "Alexander", :username => "sessions_user",
                   :password => "password1")
      get :create, sessions: {username: user.username,password:user.password}
      expect(response).to redirect_to(user)
      User.find_by(:username => user.username).destroy
    end
  end



  describe 'GET login' do
    it 'redirects to user view' do
      user = User.create(:name => "Alexander", :username => "sessions_user_2",
                   :password => "password1")
      get :login, nil, {username: user.username}
      expect(response).to redirect_to(user)
      User.find_by(:username => user.username).destroy
    end
  end

  describe 'GET login' do
    it 'redirects to user view' do
      get :logout, nil, nil
      expect(response).to redirect_to(login_url)
    end
  end



end
