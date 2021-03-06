class Photo < ActiveRecord::Base
  #list of accessible attributes
	attr_accessible :id
	attr_accessible :description
	attr_accessible :is_private
  attr_accessible :user_id
  #paper clip
  attr_accessible :photo_file_name
  attr_accessible :photo_content_type
  attr_accessible :photo_file_size
  attr_accessible :photo_updated_at

  attr_accessible :latitude
  attr_accessible :longitude


  #link table
  belongs_to :user

  #paper clip attachment file
  attr_accessible :photo
  has_attached_file :photo,
    :styles => { :large => "800x600>",   :medium => "300x300>", :small =>"250x250>", :thumb => "100x100>" },
    #try to make it work later
    #:url  => "/:hash.:extension",
    :url => "/files/:user_id/photos/:id/:style/:basename.:extension",
    :path => ":rails_root/public/files/:user_id/photos/:id/:style/:basename.:extension"
  


  #validators section

  #required attributes
  validates_presence_of  :description

  #paper clip attachment validation
  validates_attachment :photo, :presence => true,
                       :content_type => { :content_type => ["image/bmp","image/gif", "image/jpeg","image/pjpeg","image/png"] },
                       :size => { :less_than => 5.megabytes }
                       :weird_content

  #imagemagick fixes
  before_post_process :skip_for_audio
  before_post_process :skip_for_zip

  def skip_for_audio
    ! %w(audio/ogg application/ogg audio/wav).include?(photo_content_type)
  end

  def skip_for_zip
    ! %w(application/zip).include?(photo_content_type)
  end

  # define our own path
  Paperclip.interpolates :user_id do |attachment, style|
    attachment.instance.user_id.to_s
  end




  
end