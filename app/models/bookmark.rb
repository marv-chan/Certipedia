class Bookmark < ActiveRecord::Base

  def self.get_bookmarks(user)
    @bookmarks =[]
    Bookmark.all.each do |bm|
      if bm.include? user
        @bookmarks.push(bm.certificates)
      end
    end

    print(@bookmarks)
    return @bookmarks
  end


  #this fails, I have tried user and users and tried changing the schema 
  def self.add_bookmark(user, course)
    @bookmark = Bookmark.create!(:users => user, :certificates=> course)
  end

end
