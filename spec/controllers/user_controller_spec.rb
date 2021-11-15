require 'rails_helper'


RSpec.describe UsersController, type: :controller do
  before(:all) do
    if User.where(:name => "Alexander Preau").empty?
      User.create(:name => "Alexander Preau", :username => "test1",
                   :password => "password1")
      User.create(:school => "New York University", :name => "C++",
                  :subject => "Computer Science", :website => "http://test.com")

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

    it ' render the index' do
      get :index
      expect(response).to render_template('index')
    User.find_by(:name => "Marvin").destroy
    end
  end


  describe 'GET edit' do
    user = User.create(:name => "Marvin", :username => "test2",
                  :password => "password2")
    before(:each) do
      get :edit, id: user.id
    end

    it 'find the user' do
      expect(assigns(:User)).to eql(user)
    end

    it 'should render the show template' do
      expect(response).to render_template('edit')
    end
    User.find_by(:name => "Marvin").destroy
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

  it 'should find the user' do
    expect(assigns(:User)).to eql(user)
  end

  it 'render show' do
    expect(response).to render_template('show')
  end
  User.find_by(:name => "Marvin").destroy
end


describe 'PUT update' do
  user = User.create(:name => "Marvin", :username => "test2",
                :password => "password2")
  before(:each) do
    put :update, id: user.id,  :User => {:name => "Modified"}
  end

  it 'updates a user' do
    user.reload
    expect(user.name).to eql('Modified')
  end

  it 'redirects to the user page' do
    expect(response).to redirect_to(User_path(user))
  end
  User.find_by(:name => "Marvin").destroy
end


end
