class Photo < ActiveRecord::Base
  #list of accessible attributes
	attr_accessible :name
	attr_accessible :id
	attr_accessible :description
	attr_accessible :is_private
	attr_accessible :file_type
	attr_accessible :date_uploaded
  attr_accessible :path

  #paper clip attachment file
  attr_accessible :photo_file
  has_attached_file :photo_file, :styles => { :large => "800x600>",   :medium => "300x300>", :small =>"250x250>", :thumb => "100x100>" }

  #validators section

  #required attributes
  validates_presence_of  :description,:is_private

  #paper clip attachment validation
  validates_attachment :photo_file, :presence => true,
                       :content_type => { :content_type => "image/bmp image/gif image/jpeg image/pjpeg image/png" },
                       #:size => { :in => 0..10.kilobytes }

  #return true , error message if not
	def self.save(new_photo)
    
		#allowed content types check if correct

    abort(config.paperclip_defaults)


    #manual validation .. dont need anymore with paper clip
		#allowed_content_types = %w[image/bmp image/gif image/jpeg image/pjpeg image/png]
		#if !allowed_content_types.include? new_photo['upload']['photo'].content_type
		#	return "Error, the file type "+ new_photo['upload']['content_type'] + " is incorrect"
		#else

		#upload the file

    #fake id
    user_id = "1"
    #should be global variable ..where?
    directory = "public/photos"
    #build user dir
    user_dir = File.join(directory,user_id)
    if !File.directory? user_dir
      #does not exist we create
      Dir.mkdir(user_dir,0700)
    end

    #build file path
    file_path = File.join(user_dir,new_photo['upload']['photo'].original_filename)
    File.open(file_path, "wb") { |f| f.write(new_photo['upload']['photo'].read) }
    #check if file was correctly uploaded

    #insert the record :id => "1",
    @p = Photo.new( :name => new_photo['upload']['photo'].original_filename , :description => new_photo['@new_photo']['description'] , :file_type => new_photo['upload']['photo'].content_type, :date_uploaded => Time.now , :is_private => new_photo['@new_photo']['is_private'],:path => user_dir )
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
