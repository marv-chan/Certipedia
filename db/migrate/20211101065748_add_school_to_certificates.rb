class AddSchoolToCertificates < ActiveRecord::Migration
  def change
    add_column :certificates, :school, :string
  end
end
