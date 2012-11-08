class SessionController < ApplicationController


  def create
    #can return many users.. so have to for each and take only first one..retarded
    @users = User.where("login = ? AND password = ? ",params[:user_login]['login'], Digest::MD5.hexdigest(params[:user]['password'])).limit(1)
    #check if user exists
    if @users.exists?
      @users.each do |user|
        session[:user_id] = user.id
      end
      redirect_to "/photoUploadix/users/#{session[:user_id]}"
    else
      flash[:error] = "Error, this combinaison is invalid. Please try again."
      @users = nil
      render "site/index"
    end

    #
    
    
  end

  def new
    @session = session.new
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to "/photoUploadix/site/index"
  end
end