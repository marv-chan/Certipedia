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

  def self.add_bookmark(user, certificate)
    @bookmark = Bookmark.create(:users_id => user.id, :certificates_id => certificate.id)
  end

end
