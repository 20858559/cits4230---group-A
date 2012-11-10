class FriendsController < ApplicationController
  def confirm
    #placeholder
  end
  def confirm_ok
    user = User.find(params[:id])
    _friend = Friend.where("id_one = ? AND id_two = ?",current_user.id,params[:id])
    friend = Friend.find(_friend[0].id)
    friend.relationship = 1
    friend.save
    flash[:notice] = "#{user.first_name} #{user.last_name} is now your friend."
    redirect_to root_url
  end
  def confirm_ko
    user = User.find(params[:id])
    _friend = Friend.where("id_one = ? AND id_two = ?",current_user.id,params[:id])
    friend = Friend.find(_friend[0].id)
    friend.delete
    flash[:notice] = "#{user.first_name} #{user.last_name} 's friend request was deleted."
    redirect_to root_url
  end
  def create
    @friendship = current_user.friendships.build(:id_one => params[:id_one])
    if @friendship.save
      flash[:notice] = "Successfully created friendship."
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
