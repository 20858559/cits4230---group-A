class PhotoController < ApplicationController
	#index action
	def index
    #list of photos
    render :file => 'photo/index.rhtml'
  end
  #add a new photo
  def add_photo
    @new_photo = Photo.new
    render :file => 'photo/add_photo.rhtml'
  end
	#save action
  def save_photo
    result = Photo.save(params)
    if result == true
      puts "Success"
      redirect_to :action => "index"
    else
      redirect_to :action => "add_photo"
    end
    
  end
end
