require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  before(:all) do
    if User.where(:name => "Alexander Preau").empty?
      User.create(:name => "Alexander Preau", :username => "test1",
                   :password => "password1")

    end
  end




  describe "creates" do
    it "user with valid parameters" do
      get :create, {:user => {:name => "Marvin", :username => "test2",
                    :password => "password2"}}
      expect(flash[:notice]).to match(/User was created/)
      User.find_by(:name => "Marvin").destroy
    end
  end






  describe 'GET index' do
    user = User.create(:name => "Marvin", :username => "test2",
                  :password => "password2")

    it ' rendirect to new user' do
      get :index
      expect(response).to redirect_to('/users/new')
    User.find_by(:name => "Marvin").destroy
    end
  end



  describe 'GET new' do
    user = User.new

    it 'render new' do
      get :new
      expect(response).to render_template('new')
    end
  end


  describe 'GET show' do
    user = User.create(:name => "Marvin", :username => "test2",
                  :password => "password2")
  before(:each) do
    get :show, id: user.id
  end
  print(user.id)


  it 'should find the user' do
    expect(assigns(:user)).to eql(user)
  end

  it 'render show' do
    expect(response).to render_template('show')
  end
  User.find_by(:name => "Marvin").destroy
end




end
