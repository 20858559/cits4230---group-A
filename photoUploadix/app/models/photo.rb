class Photo < ActiveRecord::Base
  #list of accessible attributes
	attr_accessible :name
	attr_accessible :id
	attr_accessible :description
	attr_accessible :is_private
	attr_accessible :file_type
	attr_accessible :date_uploaded

  #validators

  #required
  validates_presence_of  :name,:description,:is_private

  #return true , error message if not
	def self.save(new_photo)
    #check validation here
		#allowed content types check if correct
		allowed_content_types = %w[image/bmp image/gif image/jpeg image/pjpeg image/png]
		if !allowed_content_types.include? new_photo['upload']['photo'].content_type
			return "Error, the file type "+ new_photo['upload']['content_type'] + " is incorrect"
		else
      
			#upload the file
			directory = "public/photos"
			path = File.join(directory, name)
			File.open(path, "wb") { |f| f.write(new_photo['upload']['photo'].read) }
			#check if file was correctly uploaded

			#insert the record :id => "1",
			@p = Photo.new( :name => new_photo['upload']['photo'].original_filename , :description => new_photo['@new_photo']['description'] , :file_type => new_photo['upload']['photo'].content_type, :date_uploaded => Time.now , :is_private => new_photo['@new_photo']['is_private'] )
      #abort(@p.inspect)
			if @p.new_record?
				if @p.save
           return true
           
        else
           return "There was an error"
        end
			end
			
		end


	end
end
