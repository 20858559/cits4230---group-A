class SessionController < ApplicationController
  def create
    user, message = User.authenticate(params[:user_login]['login'],params[:user_login]['password'])
    #check if user exists
    if message.eql?("")
        session[:user_id] = user.id
        redirect_to user_path(session[:user_id])
        flash[:notice] = "Logged in"
    else
      flash[:error] = message
      redirect_to :root
    end
     
      
    
  end

  def new
    
  end

  def destroy
    reset_session
    flash[:notice] = "Successfully logged out"
    redirect_to :root
  end

end