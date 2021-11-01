class AddWebsiteToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :website, :string
  end
end
