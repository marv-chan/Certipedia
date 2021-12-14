class CertificatesController < ApplicationController

  def show
    id = params[:id]
    uname = session[:username]
    @bookmarked = false
    @certificate = Certificate.find(id)
    if uname == nil
      return
    end
    @user = User.joins(:bookmarks).where(
      username: uname,
      bookmarks: {certificate_id: @certificate.id})
    if !@user.empty?
      @bookmarked = true
    end
  end

  Schools = Struct.new(:name,:id) do
  end

  Subjects = Struct.new(:name,:id) do
  end

  def index

    @all_schools = Certificate.all_schools
    @all_subjects = Certificate.all_subjects
    @selected_schools = []
    @selected_subjects = []
    @sort = nil

    if params[:refresh] == nil and params[:sort] == nil
      session[:subjects] = nil
      session[:schools] = nil
      session[:sort] = nil
      @certificates = Certificate.with_filter([], [])
      return
    elsif params[:refresh] != nil

      if params[:schools] != nil
        @selected_schools = params[:schools]
        session[:schools] = @selected_schools
      else
        session[:schools] = []
      end

      if params[:subjects] != nil
        @selected_subjects = params[:subjects]
        session[:subjects] = @selected_subjects
      else
        session[:subjects] = []
      end

      if session[:sort] != nil
        @sort = session[:sort]
      end

    elsif params[:sort] != nil
      print("in sort\n")
    
      if session[:schools] != nil
        @selected_schools = session[:schools]
      end

      if session[:subjects] != nil
        @selected_subjects = session[:subjects]
      end

      @sort = params[:sort]
      session[:sort] = @sort
    end

    @certificates = Certificate.with_filter(@selected_schools, @selected_subjects).order(@sort)

    @name_header = (@sort == 'name') ? "hilite" : ""
    @subject_header = (@sort == 'subject') ? "hilite" : ""
    @school_header = (@sort == 'school') ? "hilite" : ""
  end

  def new
    # default: render 'new' template
  end

  def create
    if session[:admin] == nil
      flash[:notice] = "You don't have permission to create certificate"
      redirect_to certificates_path
      return
    end
    @certificate = Certificate.create!(certificate_params)
    flash[:notice] = "#{@certificate.name} was successfully created."
    redirect_to certificates_path
  end


  def update
    if session[:admin] == nil
      flash[:notice] = "You don't have permission to update certificate"
      redirect_to certificate_path(@certificate)
      return
    end
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
