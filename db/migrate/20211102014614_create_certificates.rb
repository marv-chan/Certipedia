class CreateCertificates < ActiveRecord::Migration
  def up
    create_table :certificates do |t|
      t.string :name
      t.string :school
      t.string :subject
      t.string :website
      t.timestamps
    end
  end

  def down
            drop_table :certificates
  end
end
