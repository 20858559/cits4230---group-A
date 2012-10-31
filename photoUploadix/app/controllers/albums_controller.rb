class AlbumsController < ApplicationController
	def manage
		@user = User.find(params[:user_id])
		
		@albums = @user.albums
		
		render :file => 'album/manage.rhtml'
	end

	def show
	    #check if logged in user
	    if session[:user_id].to_s == params[:id]
	      @user = User.find(params[:id])
	      @photos = @user.photos
	    else
	      raise ActionController::RoutingError.new('Not Found')
	    end

 	end
	

end
