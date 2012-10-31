class PhotosController < ApplicationController
	#index action .. all public photos from db or public + private logged
	def index
    if session[:user_id].to_s != params[:id]
      raise ActionController::RoutingError.new('Not Found')
    end
  end

  def edit
    @photo = Photo.find(params[:id])
  end


  def public_gallery

    #list of photos

    @photos = Photo.where("is_private = false")
  end
  

  def show
    if session[:user_id].to_s != params[:id]
      raise ActionController::RoutingError.new('Not Found')
    end
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
      redirect_to "/photoUploadix/users/#{session[:user_id]}"
    else
      @photo.photo = nil
      render :action => "new"
    end
  end
  def new
    @photo = Photo.new
  end
	
end
