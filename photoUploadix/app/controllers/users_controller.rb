class UsersController < ApplicationController
	#before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    #check if logged in user show all

    @user = User.find(params[:id])
    
    if session[:user_id].to_s == params[:id]

      @photos = @user.photos
    else
      #show only public
    #  raise ActionController::RoutingError.new('Not Found')
      @photos = @user.photos.where("is_private = false")
    end

  end

  def new
    @user = User.new
    
  end

  def create
    @user=User.new(params[:user])

    #abort(@user.inspect)
    if !@user.nil?
      #generate code
      login_hash = Digest::MD5.hexdigest(@user.login)
      pw_hash = Digest::MD5.hexdigest(@user.password)
      first_name_hash = Digest::MD5.hexdigest(@user.first_name)
      code = (pw_hash[0..4] + login_hash[4..8]+ first_name_hash[4..8])*2
       
      if @user.save
        #update pw with hash
        @new_user = User.find(@user.id)
        @new_user.password = pw_hash
        @new_user.code = code[0..4]
        @new_user.save
        flash[:notice] = "User was successfully created"
        redirect_to "/photoUploadix"
      else
        render :action => "new"
      end

    else
      render :action => "new"
    end

  end

  def private_gallery
    if !session[:user_id].nil?
      #get friends
      @photos = Photo.joins("INNER JOIN users ON  users.id= photos.user_id INNER JOIN friends ON users.id = friends.id_two   ").where("id_one="+session[:user_id].to_s).where("photos.is_private = true")
      #get their photos

    else
      raise ActionController::RoutingError.new('Not Found')
      
    end
    
  end

  def edit


  end

  def update

  end

  def destroy

  end

end
