class User < ActiveRecord::Base
  has_many :friends
  

  #attr_accessor :password
  attr_accessible :name,:password,:email,:id,:login,:first_name,:last_name,:password_confirmation,:registration_token,:status

  attr_accessor :password_confirmation

  validates :first_name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :last_name,  :presence => true,
                    :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with    => /\w+@\w+\.\w+/,
                                   :message => "abc@examples.com" }

  validates :login, :uniqueness => true

  validates :password,
            :presence     => true,
            :confirmation => true,
            :length       => { :within => 6..40 }

  #activate this on cits4230 server
  #has_secure_password

  has_many :albums, :dependent => :destroy
  has_many :photos, :dependent => :destroy

  def self.authenticate(login, password)
    user = find_by_login(login)
    if user == nil
      return user, "Invalid login or password"
    else
      if  user.status == false
        return user, "Your account has not been activated yet. You should have received an activation email. Check your spam folder."
      else
        if user && user.password.eql?( Digest::MD5.hexdigest(password))       
          return user,""
        else
          return user, "Invalid login or password"
        end
      end
    end
 
          
  end


end
