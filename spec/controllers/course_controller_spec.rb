require 'rails_helper'


RSpec.describe CertificatesController, type: :controller do





  describe "creates" do
    it "certificate with valid parameters" do
      get :create, {:certificate => {:school => "New York University", :name => "Russian Language",
                    :subject => "Russian", :website => "http://test.com"}}
      expect(response).to redirect_to certificates_path
      expect(flash[:notice]).to match(/Russian Language was successfully created./)
      Certificate.find_by(:name => "Russian Language").destroy
    end
  end

  describe "creates" do
    it "certificate with invalid parameters (no subject)" do
      get :create, {:certificate => {:school => "Columbia University", :name => "JavaScript",
         :website => "http://test.com"}}
      expect(response).to redirect_to certificates_path
      expect(flash[:notice]).to match(/JavaScript was successfully created./)
      Certificate.find_by(:name => "JavaScript").destroy


    end
  end




  describe 'GET index' do
    cert =   Certificate.create(:school => "Cornell University", :name => "NoSQL",
                         :subject => "Computer Science", :website => "http://test.com")

    it ' render the index' do
      get :index
      expect(response).to render_template('index')
    Certificate.find_by(:name => "NoSQL").destroy
    end
  end




  describe 'GET new' do
    cert = Certificate.new

    it 'render new' do
      get :new
      expect(response).to render_template('new')
    end
  end


  describe 'GET show' do
    cert = Certificate.create(:school => "Cornell University", :name => "SQL",
                         :subject => "Computer Science", :website => "http://test.com")

    before(:each) do
      get :show, id: cert.id
    end

    it 'should find the cert' do
      expect(assigns(:certificate)).to eql(cert)
    end

    it 'render show' do
      expect(response).to render_template('show')
    end
  end


describe 'PUT update' do
  cert = Certificate.create(:school => "Cornell University", :name => "NoSQL",
                       :subject => "Computer Science", :website => "http://test.com")
  before(:each) do
    put :update, id: cert.id,  :certificate => {:name => "Modified"}
  end

  it 'updates a cert' do
    cert.reload
    expect(cert.name).to eql('Modified')
  end

  it 'redirects to the cert page' do
    expect(response).to redirect_to(certificate_path(cert))
  end
end

describe "destroy" do
  it "deletes a certificate" do
      orig_cert_length = Certificate.all.length()
      Certificate.find_by(:name => "NoSQL").destroy
      Certificate.find_by(:name => "SQL").destroy
      new_cert_length = Certificate.all.length()
      expect(orig_cert_length).to eq new_cert_length+2
  end
end

  after(:all) do
    Certificate.all.each {|cert|
    cert.destroy
  }
  end


end
