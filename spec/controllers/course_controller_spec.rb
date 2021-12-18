require 'rails_helper'


RSpec.describe CertificatesController, type: :controller do





  describe "creates" do

    it "certificate with valid parameters while not logged in as admin" do
      get :create, {:certificate => {:school => "New York University", :name => "Russian Language",
                    :subject => "Russian", :website => "http://test.com"}}
      expect(response).to redirect_to certificates_path
      expect(flash[:notice]).to match(/You don't have permission to create certificate/)
    end

    it "certificate with invalid parameters (no subject) while not logged in as admin" do
      get :create, {:certificate => {:school => "Columbia University", :name => "JavaScript",
         :website => "http://test.com"}}
      expect(response).to redirect_to certificates_path
      expect(flash[:notice]).to match(/You don't have permission to create certificate/)


    end

    it "certificate with valid parameters while logged in as admin" do


      get :create, {:certificate => {:school => "New York University", :name => "Russian Language",
                    :subject => "Russian", :website => "http://test.com"}},
                    {:admin => true}
      expect(response).to redirect_to certificates_path
      expect(flash[:notice]).to match(/Russian Language was successfully created./)
      Certificate.find_by(:name => "Russian Language").destroy
    end

    it "certificate with invalid parameters (no subject) while logged in as admin" do
      get :create, {:certificate => {:school => "Columbia University", :name => "JavaScript",
         :website => "http://test.com"}},
         {:admin => true}
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
  context 'While not logged in as admin' do
    before(:each) do
      put :update, id: cert.id,  :certificate => {:name => "Modified"}
    end

    it 'Fails to update a cert' do
      cert = cert.reload
      expect(cert.name).to eql('NoSQL')
    end

    it 'redirects to the cert page' do
      expect(response).to redirect_to(certificate_path(cert))
    end
  end

  context 'While logged in as admin' do
    before(:each) do
      put :update, id: cert.id,  :certificate => {:name => "Modified"},:admin => true
    end

    it 'Updates a cert' do
      cert = cert.reload
      expect(cert.name).to eql('NoSQL')
    end

    it 'redirects to the cert page' do
      expect(response).to redirect_to(certificate_path(cert))
    end
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
