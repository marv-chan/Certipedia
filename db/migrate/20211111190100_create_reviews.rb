class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.belongs_to :users
      t.belongs_to :certificates
      t.integer :rating
      t.string :review
      t.timestamps
    end
  end
end
