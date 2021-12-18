require 'rails_helper'


RSpec.describe UsersController, type: :controller do





  describe "creates" do
    it "user with valid parameters" do
      get :create, {:user => {:name => "Marvin", :username => "test2",
                    :password => "password2"}}
      expect(flash[:notice]).to match(/User was created/)
      expect(response).to redirect_to('/login')

    end

    it 'user with existing username' do
      get :create, {:user => {:name => "Marvin", :username => "test2",
                    :password => "password2"}}
      get :create, {:user => {:name => "Marvin", :username => "test2",
                    :password => "password2"}}
      expect(flash[:notice]).to match(/Username already exists/)
      expect(response).to redirect_to('/users/new')

    end
  end

  describe 'GET index' do
    user = User.create(:name => "Alexander", :username => "test3",
                  :password => "password3")


    it ' rendirect to show' do
      get :index
      expect(response).to redirect_to('/users/new')

    end
  end



  describe 'GET new' do
    user = User.new

    it 'render new' do
      get :new
      expect(response).to render_template('new')
    end
  end


  describe 'GET show on self' do

    user = User.create(:name => "Alex", :username => "new",
                  :password => "password5")

    before(:each) do
      get :show, {id: user.id}, {username: user.username}
    end

    it 'should find the user' do

      expect(assigns(:user)).to eql(user)
    end

    it 'render show' do
      expect(response).to render_template('show')
    end
  end







end
