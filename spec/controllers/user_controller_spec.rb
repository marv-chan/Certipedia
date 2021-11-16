require 'rails_helper'


RSpec.describe UsersController, type: :controller do





  describe "creates" do
    it "user with valid parameters" do
      get :create, {:user => {:name => "Marvin", :username => "test2",
                    :password => "password2"}}
      expect(flash[:notice]).to match(/User was created/)
    #  User.find_by(:name => "Marvin").destroy
    end
  end






  describe 'GET index' do
    user = User.create(:name => "Alexander", :username => "test3",
                  :password => "password3")
    print(user.name)

    it ' rendirect to show' do
      get :index
      expect(response).to redirect_to('/users/new')
  #  User.find_by(:name => "Alexander").destroy
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
    user = User.create(:name => "Nidhi", :username => "test4",
                  :password => "password4")
    print(user)
  before(:each) do
    get :show, id: user.id, username: user.username
  end
  #print(user.id)


  it 'should find the user' do
    expect(assigns(:user)).to eql(user)
  end

  it 'render show' do
    expect(response).to render_template('show')
  end
  User.find_by(:name => "Nidhi").destroy
end

  after(:all) do

    User.all.each {|user|
      user.destroy
  }
  end




end
