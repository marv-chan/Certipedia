require 'rails_helper'

RSpec.describe CertificatesController, type: :controller do
  before(:all) do
    if Certificate.where(:school => "Columbia University").empty?
      Certificate.create(:school => "Columbia University", :name => "SQL",
                   :subject => "Computer Science", :website => "http://test.com")
      Certificate.create(:school => "New York University", :name => "C++",
                  :subject => "Computer Science", :website => "http://test.com")

    end
  end
end 
