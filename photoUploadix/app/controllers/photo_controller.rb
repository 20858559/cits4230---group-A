class PhotoController < ApplicationController
	#index action
	def index
     		render :file => 'photo/uploadPhoto.rhtml'
  	end
	#upload action
  	def upload
    		post = Photo.save(params[:upload])
    		render :file => 'photo/uploadPhoto.rhtml'
  	end
end
