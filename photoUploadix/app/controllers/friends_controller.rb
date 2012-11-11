class FriendsController < ApplicationController
  def confirm
    #placeholder
  end
  def confirm_ok
    user = User.find(params[:id])
    _friend = Friend.where("id_one = ? AND id_two = ?",params[:id],current_user.id)
    friend = Friend.find(_friend[0].id)
    friend.relationship = 1
    friend.save
    #add the relationship in the other way
    _new_friend = Friend.new
    _new_friend.id_two = params[:id]
    _new_friend.id_one =current_user.id
    _new_friend.relationship = 1
    _new_friend.save

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
    _user_friend = User.find(params[:id])
    flash[:notice] = "Request sent to #{_user_friend.first_name} #{_user_friend.last_name} "
    _friend = Friend.new
    _friend.id_one = current_user.id
    _friend.id_two = _user_friend.id
    _friend.relationship = 0
    _friend.modification_date =  Time.now
    _friend.save
    render :text => "OK"
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    flash[:success] = "Successfully destroyed friendship."
    redirect_to root_url
  end

  def show

  end

  def index
    
  end
end
