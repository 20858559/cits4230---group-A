class UsersController < ApplicationController
	#before_filter :authenticate_user!

  def index
    @users = User.all
  end

  def show
    #check if logged in user
    if session[:user_id].to_s == params[:id]
      @user = User.find(params[:id])
      @photos = @user.photos
    else
      raise ActionController::RoutingError.new('Not Found')
    end

  end

  def new
    @user = User.new(params)
    @user.save

  end

  def create

    #session[:user_id] = params

  end

  def edit


  end

  def update

  end

  def destroy

  end



end
