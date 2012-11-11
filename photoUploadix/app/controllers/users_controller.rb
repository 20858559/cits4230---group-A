class UsersController < ApplicationController

  #index displays all existing users
  def index
    if current_user
      @users = User.where("id <> ? AND NOT EXISTS(SELECT id_one FROM friends WHERE id_one = ? )",current_user.id,current_user.id)
    else
      @users = User.all
    end
    
  end
  #show displays the informations for one user
  def show
    #get the user with the url
    @user = User.find(params[:id])

    #check if user is the one logged in
    if session[:user_id].to_s == params[:id]
      #then show all his pictures
      @photos = @user.photos
    else
      #show only public pictures
      @photos = @user.photos.where("is_private = false")
    end

  end
  #display the form to create a new user
  def new
    @user = User.new
  end
  #takes care of the user creation
  def create
    @user=User.new(params[:user])
    if !@user.nil?
      pw_hash = Digest::MD5.hexdigest(@user.password)
      #if validation was ok we can update the user
      if @user.save
        #update pw with hash
        @new_user = User.find(@user.id)
        @new_user.password = pw_hash
        #set user status to inactive
        @new_user.status = false;
        #generate random token for confirmation mail
        uuid = UUID.new
        @new_user.registration_token = uuid.generate
        @new_user.save
        #send the mail
        Notifier.send_registration_confirmation(@new_user).deliver
        flash[:notice] = "User was successfully created"
        redirect_to :root
      else
        render :action => "/new"
      end

    else
      render :action => "/new"
    end

  end

  #allow to browse friends pictures
  def private_gallery
    if !session[:user_id].nil?
      #get friends
      @photos = Photo.joins("INNER JOIN users ON  users.id= photos.user_id INNER JOIN friends ON users.id = friends.id_two   ").where("id_one= ? AND photos.is_private = true AND friends.relationship =1 ",session[:user_id].to_s)
      #get their photos

    else
      raise ActionController::RoutingError.new('Not Found')
      
    end
    
  end

  def edit
  end

  def update
  end

  #deletes a user
  def destroy
  end

  #checks that the token is correct, updates the token and activate the user
  def confirm_registration
    @user = User.find(params[:user_id])
    if @user.registration_token.eql?(params[:registration_token])
      #tokens match.. change user status and destroy token
      @user.status = true
      @user.registration_token = ""
      @user.save
      flash[:notice] = "Congratulations " + @user.login + ". Your account was successfully activated!"
    else
      flash[:error] = "Sorry the tokens mismatch, please make sure that you are accessing the correct link."  
    end
  end
end
