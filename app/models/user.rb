class User < ActiveRecord::Base
  has_many :bookmarks
  has_many :certificates, :through => :bookmarks


  def self.try_login(params)
    uname = params[:username]
    pword = params[:password]
    name = params[:name]
    @found_user = User.where(username: uname, password: pword, name: name)
    if @found_user.empty?
      return false
    end

    return @found_user.first
  end

  def self.make_new_user(params)
    uname = params[:username]
    pword = params[:password]
    name = params[:name]


    @user = User.create(:username => uname,:password =>pword,:name => name)
    return @user
  end

  def self.get_user(uname)
    @user = User.where(:username =>uname)
    if @user.empty?
      return false
    end

    return @user.first
  end


end
