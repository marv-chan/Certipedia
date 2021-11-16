class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :certificate

  # def self.get_bookmarks(user)
  #   @bookmarks =[]
  #   Bookmark.all.each do |bm|
  #     if bm.include? user
  #       @bookmarks.push(bm.certificates)
  #     end
  #   end

  #   print(@bookmarks)
  #   return @bookmarks
  # end

  def self.add_bookmark(user, certificate)
    @bookmark = Bookmark.create(:user_id => user.id, :certificate_id => certificate.id)
  end

end
