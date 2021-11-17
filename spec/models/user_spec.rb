require 'rails_helper'


RSpec.describe User, type: :model do

  describe 'Try to login' do
    it 'without a valid existing user' do
      @user = User.try_login({username: nil, password: nil, name: nil})
      expect(@user).to  eq(false)
    end


    it 'with a valid existing user' do
      user = User.create(:name => "Alexander", :username => "user_spec",
                    :password => "password3")
      @user = User.try_login({username: user.username, password: user.password, name: user.name})
      expect(@user).to  eq(user)
      User.find_by(:username => "user_spec").destroy
    end
  end


  describe 'Make new user' do
    it 'with valid parameters' do
      @user = User.make_new_user({username: 'user_spec', password: 'test', name: 'Alexander'})
      expect(@user.name).to eq('Alexander')
      User.find_by(:username => "user_spec").destroy
    end
  end


  describe 'Get user by username' do
    it 'without valid username' do
      @user = User.get_user("bad")
      expect(@user).to eq(false)
    end

    it 'with valid username' do
      user = User.create(:name => "Alexander", :username => "user_spec",
                    :password => "password3")
      @user = User.get_user(user.username)
      expect(@user).to eq(user)
    end
  end


end
