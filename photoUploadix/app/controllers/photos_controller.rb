class PhotosController < ApplicationController
	#index action .. all public photos from db or public + private logged
	def index
    #list of photos

    #authorized?

    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    #get all photos from the user
    @photos = Photo.where("is_private = false")
  end

  def edit
    @photo = Photo.find(params[:id])
  end

  

  def show
    @user = User.find(params[:user_id])
    @photo = Photo.find(params[:id])
  end
  def create
  #add a new photo
    @user = User.find(params[:user_id])
    @photo = @user.photos.new(params[:photo])
    #take one from session
    #@photo.user_id = 1
    if @photo.save
      flash[:notice] = "Successfully uploaded photo."
      redirect_to :action => user_photo
    else
      @photo.photo = nil
      render :action => "new"
    end
  end
  def new
    @photo = Photo.new
  end
	
end
