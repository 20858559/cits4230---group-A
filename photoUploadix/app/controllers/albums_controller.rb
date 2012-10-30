class AlbumsController < ApplicationController
	def manage
		render :file => 'album/manage.rhtml'
	end
end
