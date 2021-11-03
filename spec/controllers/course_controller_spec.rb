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

  describe "destroy" do
    it "deletes a certificate" do
        orig_cert_length = Certificate.all.length()
        Certificate.find_by(:name => "SQL").destroy
        Certificate.find_by(:name => "C++").destroy
        new_cert_length = Certificate.all.length()
        expect(orig_cert_length).to eq new_cert_length+2
    end
  end


  describe 'GET index' do
    cert =   Certificate.create(:school => "Cornell University", :name => "NoSQL",
                         :subject => "Computer Science", :website => "http://test.com")

    it ' render the index' do
      get :index
      expect(response).to render_template('index')
    Certificate.find_by(:school => "Cornell University").destroy
    end
  end


  describe 'GET edit' do
    cert = Certificate.create(:school => "Cornell University", :name => "NoSQL",
                         :subject => "Computer Science", :website => "http://test.com")
    before(:each) do
      get :edit, id: cert.id
    end

    it 'find the cert' do
      expect(assigns(:certificate)).to eql(cert)
    end

    it 'should render the show template' do
      expect(response).to render_template('edit')
    end
    Certificate.find_by(:school => "Cornell University").destroy
  end


  describe 'GET new' do
    cert = Certificate.new

    it 'render new' do
      get :new
      expect(response).to render_template('new')
    end
  end


  describe 'GET show' do
    cert = Certificate.create(:school => "Cornell University", :name => "NoSQL",
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
  Certificate.find_by(:school => "Cornell University").destroy
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
  Certificate.find_by(:school => "Cornell University").destroy
end


end
