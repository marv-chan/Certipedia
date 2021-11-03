require 'rails_helper'

RSpec.describe Certificate, type: :model do
  before(:all) do
    if Certificate.where(:school => "Cornell University").empty?

        Certificate.create(:school => "Cornell University", :name => "SQL",
                     :subject => "Computer Science", :website => "http://test.com")
        Certificate.create(:school => "Cornell University", :name => "C++",
                    :subject => "Computer Science", :website => "http://test.com")

    end
end

  describe "filter" do
    it "returns all certs if no filter added" do
      certs = Certificate.with_filter([],[],0)
      all_certs = Certificate.where(school: Certificate.all_schools, subject: Certificate.all_subjects)
      expect(certs.length()).to eq all_certs.length
    end
  end

  describe "filter" do
    it "returns correctly filtered certs" do
      certs = Certificate.with_filter(["Cornell University"],[],0)
      correct_certs = all_certs = Certificate.where(school: ['Cornell University'], subject: Certificate.all_subjects)
      expect(certs.length()).to eq correct_certs.length()
      Certificate.find_by(:name => "SQL").destroy
      Certificate.find_by(:name => "C++").destroy


    end
  end

  describe "all schools" do
    it "all schools should be a list of all schools" do
      expect(Certificate.all_schools).to eq ['Columbia University', 'New York University', 'Cornell University']
    end
  end
end
