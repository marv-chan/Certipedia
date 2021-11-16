class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.belongs_to :users
      t.belongs_to :certificates
      t.timestamps
    end
  end
end
