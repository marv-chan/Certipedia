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
    @schools = Array.new(3)
    i = 0
    @all_schools.each do |s|
      @schools[i] = Schools.new(s,i)
      i = i + 1
    end

    @all_subjects = Certificate.all_subjects


    @subjects = Array.new(2)
    i = 0
    @all_subjects.each do |s|
      @subjects[i] = Subjects.new(s,i)
      i = i + 1
    end


    switch = false

    if params[:sort]

      @sorted = params[:sort]
    elsif session[:sort]
      @sorted = session[:sort]
      switch = true
    end

    if params[:schools]
      if params[:schools] == [""]
        @schools_to_show = @all_schools
      else
        @schools_to_show = params[:schools]
      end

    elsif session[:schools]
       @schools_to_show = session[:schools]
       switch = true
    else
      @schools_to_show = @all_schools
    end


    if params[:subjects]
      if params[:subjects] == [""]
        @subjects_to_show = @all_subjects
      else
        @subjects_to_show = params[:subjects]
      end

      #print("params")

    elsif session[:subjects]

      @subjects_to_show = session[:subjects]
#    switch = true
    #  print("session")
    else
      @subjects_to_show = @all_subjects
  #    print("recovered from hash")
    end
  #  print(@subjects_to_show)
  #  print("printing session")
  #  print(session[:subjects])

    if switch
      redirect_to certificates_path(:sort => @sorted, :schools => @schools_to_show,:subjects => @subjects_to_show)
    end

    @certificates = Certificate.with_filter(@schools_to_show,@subjects_to_show)
    if @sorted
      @certificates = Certificate.with_filter(@schools_to_show,@subjects_to_show).order(@sorted)
    end

    session[:sort] = @sorted
    session[:schools] = @schools_to_show

    session[:subjects] = @subjects_to_show




    @name_header = (params[:sort] == 'name') ? "hilite" : ""

    @subject_header = (params[:sort] == 'subject') ? "hilite" : ""
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
      @certificate = Certificate.find params[:id]
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
