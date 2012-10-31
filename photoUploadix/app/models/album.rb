class Album < ActiveRecord::Base
  belongs_to :users
  has_many :photos, :dependent => :destroy

	attr_accessible :user_id, :name, :description

	#Set photo to private
	def setPrivate(photoId)
		con.query("
			UPDATE photo
			SET is_private='1'
			WHERE id = " + photoId)
	end

	#Set photo to public
	def setPublic(photoId)
		con.query("
			UPDATE photo
			SET is_private='0'
			WHERE id = " + photoId)
	end

	#Check Get Photo
	def getPhotoInfo (photoId)
		temp = con.query("
			SELECT *
			FROM photo
			Where id= " + photoId)
		return temp
	end

	#Get Album Photos
	def getPhotoInAlbum (albumId)
		temp = con.query("
			SELECT * 
			FROM photo
			JOIN album_photo
			ON photo.id = album_photo.photo_id
			JOIN album
			ON album_photo.album_id = album.id
			WHERE album.id = " + albumId)
		return temp
	end

	#Add description
	def addDescription (description)
		con.query("
			INSERT INTO photo (description)
			VALUES " + description)
	end

	#LIKE
	def like (photoId)
		con.query("
			UPDATE album
			SET like = '1'
			WHERE id = " + photoId)
	end

	#Get all Albums id
	def getAlbums(userId)
		temp = con.query("
			SELECT album_id
			FROM user_album
			WHERE userId = " + userId)
		return temp
	end

	#Get Album info
	def getAlbumInfo (albumId)
		temp = con.query("
			SELECT *
			FROM album
			WHERE album_id = " +  albumId)
		return temp
	end

	#Get User Details
	def getUserInfo(userId)
		temp = con.query("
			SELECT * 
			FROM users
			WHERE id =  " + userId)
		return temp
	end

end 
