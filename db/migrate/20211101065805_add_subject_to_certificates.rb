class AddSubjectToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :subject, :string
  end
end
