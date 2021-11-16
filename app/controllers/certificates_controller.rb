class CertificatesController < ApplicationController

  def show
    id = params[:id]
    uname = session[:username]
    @bookmarked = true
    @certificate = Certificate.find(id)
    if uname == nil
      return
    end
    @user = User.joins(:bookmarks).where(
      username: uname,
      bookmarks: {certificate_id: @certificate.id})
    if @user.empty?
      @bookmarked = false
    end
  end

  def index
    @all_schools = Certificate.all_schools

    switch = false

    if params[:sort]
      @sorted = params[:sort]
    elsif session[:sort]
      @sorted = session[:sort]
      switch = true
    end

    if params[:schools]
      @schools_to_show = params[:schools]
    elsif session[:schools]
      @schools_to_show = session[:schools]
      switch = true
    else
      @schools_to_show = Hash[@all_schools.map {|v| [v,1]}]
    end

    if switch
      redirect_to certificates_path(:sort => @sorted, :schools => @schools_to_show)
    end

    @certificates = Certificate.with_schools(@schools_to_show)
    if @sorted
      @certificates = Certificate.with_schools(@schools_to_show).order(@sorted)
    end

    session[:sort] = @sorted
    session[:schools] = @schools_to_show

    @name_header = (params[:sort] == 'name') ? "hilite" : ""

    @subject_header = (params[:sort] == 'subject') ? "hilite" : ""
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
