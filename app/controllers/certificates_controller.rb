class CertificatesController < ApplicationController

  def show
    id = params[:id]
    @certificate = Certificate.find(id)
  end

  def index
    @certificates = Certificate.all
  end

  def new
    # default: render 'new' template
  end

  def create
    @certificate = Certificate.create!(certificate_params)
    flash[:notice] = "#{@certificate.name} was successfully created."
    redirect_to certificates_path
  end

  def edit
    @certificate = Certificate.find params[:id]
  end

  def update
    @certificate = Certificate.find params[:id]
    @certificate.update_attributes!(certificate_params)
    flash[:notice] = "#{@certificate.name} was successfully updated."
    redirect_to certificate_path(@certificate)
  end

  def destroy
    @certificate = Certificate.find(params[:id])
    @certificate.destroy
    flash[:notice] = "Certificate '#{@certificate.name}' deleted."
    redirect_to certificates_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def certificate_params
    params.require(:certificate).permit(:name, :school, :website, :subject)
  end
end
