require 'rails_helper'


RSpec.describe CoursesController, type: :controller do
  before(:all) do
    if Course.where(:university => "Columbia").empty?
      Movie.create(:university => "Columbia", :title => "SQL",
                   :department => "Computer Science", :application_deadline => "2021-12-10")
      Movie.create(:university => "NYU", :title => "C++",
                  :department => "Computer Science", :application_deadline => "2022-1-10")

    end
  end


  describe "creates" do
    it "course with valid parameters" do
      get :create, {:course => {:university => "NYU", :title => "Russian",
                    :department => "Russian", :application_deadline => "2021-12-10"}}
      expect(response).to redirect_to courses_path
      expect(flash[:notice]).to match(/New course was successfully created./)
      Movie.find_by(:title => "Russian").destroy
    end
  end


end
