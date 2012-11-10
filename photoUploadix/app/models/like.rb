class Like < ActiveRecord::Base

  #list of accessible attributes
	attr_accessible :photo_id
	attr_accessible :user_id
  attr_accessible :modification_date
  attr_accessible :id

  belongs_to :user
  belongs_to :photo
  

end