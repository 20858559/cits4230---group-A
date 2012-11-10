class SessionController < ApplicationController
  def create
    user = User.authenticate(params[:user_login]['login'],params[:user_login]['password'])
    #check if user exists
  
    if user.id?
        session[:user_id] = user.id
        flash[:notice] = "Logged in"
        redirect_to user_path(session[:user_id])
    else
      case user
        when 1
          msg = "User is not activated yet"
        when 2
          msg = "Invalid login or password"
      end
      flash[:error] = msg
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