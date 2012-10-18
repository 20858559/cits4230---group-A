class Photo < ActiveRecord::Base
	attr_accessible :name
	attr_accessible :id
	attr_accessible :description
	attr_accessible :path
	attr_accessible :isPrivate
	attr_accessible :fileType
	attr_accessible :dateUploaded
	def self.save(upload)
		#allowed content types
		allowedContentTypes = %w[image/bmp image/gif image/jpeg image/pjpeg image/png] 
		if allowedContentTypes.include? upload['photo'].content_type
			puts "ERROR"
		else
			#upload the file
			directory = "public/photos"
			path = File.join(directory, name)
			File.open(path, "wb") { |f| f.write(upload['datafile'].read) }
			#check if file was correctly uploaded

			#insert the record
			p = Photo.new(:id => "1", :name => :upload['photo'].original_filename) , :description => "From ror" , :fileType => :upload['photo'].original_filename), :dateUploaded => "NOW()", :path => "mySuperPath" , :isPrivate => "1" )
			p = Photo.new(:name => :upload['photo'].original_filename)
			#if p.new_record?
				p.save
			#end
			
		end
		#check that the content type is correct
		#if upload['photo'].content_type 

	end
end
