class FriendshipsController < ApplicationController
  def create
    @friendship = current_user.friendships.build(:id_one => params[:id_one])
    if @friendship.save
      flash:[:notice] = "Successfully created friendship."
      redirect_to root_url
    else
      render :action => 'new'
    end 
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Successfully destroyed friendship."
    redirect_to root_url
  end
end
