class User < ActiveRecord::Base
  #attr_accessor :password
  attr_accessible :name,:password,:email,:id

  validates :name,  :presence => true, :uniqueness => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with    => /\w+@\w+\.\w+/,
                                   :message => "abc@examples.com" }



  validates :password,
            #:presence     => true,
            #:confirmation => true,
            :length       => { :within => 6..40 }

  #activate this on cits4230 server
  #has_secure_password

  has_many :albums, :dependent => :destroy
  has_many :photos, :dependent => :destroy


end