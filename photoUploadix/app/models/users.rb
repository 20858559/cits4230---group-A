class User < ActiveRecord::Base
  #attr_accessor :password
  attr_accessible :name,:password,:email,:password_confirmation

  validates :name,  :presence => true, :uniqueness => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with    => /\w+@\w+\.\w+/,
                                   :message => "abc@examples.com" }

  # Automatically create the virtual attribute
  #    'password_confirmation'.

  validates :password, #:presence     => true,
#                      :confirmation => true,
                       :length       => { :within => 6..40 }

  has_secure_password
end