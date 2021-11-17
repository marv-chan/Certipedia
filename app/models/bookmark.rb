class Bookmark < ActiveRecord::Base
  belongs_to :user
  belongs_to :certificate

  def self.add_bookmark(user, certificate)
    @bookmark = Bookmark.create(:user_id => user.id, :certificate_id => certificate.id)
  end

end
