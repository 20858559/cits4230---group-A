class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  private
  #get current user_id source http://railscasts.com/episodes/250-authentication-from-scratch
  def current_user
    @_current_user ||= session[:user_id] && User.find(session[:user_id])
  end

  helper_method :user_feed
  private

  def user_feed
    
    items = ActiveRecord::Base.connection.execute("SELECT id,modification_date,type FROM (
      SELECT id,modification_date,'likes' as type FROM likes WHERE photo_id IN (SELECT id FROM photos WHERE user_id = #{current_user.id})
      UNION
      SELECT id,modification_date,'friends' as type FROM friends WHERE id_one = #{current_user.id}
    ) items
  ORDER BY modification_date DESC LIMIT 0,10")
    _user_feed=Array.new(items.size ,Hash.new)
    _index =0
    
    items.each  do |item|
      #get text
      
      
      if item[2].eql? "friends"
        _friend = Friend.find(item[0])
        _user = User.find(_friend.id_two)
        if _friend.relationship.eql? 0
          _text = "#{_user.first_name}  #{_user.last_name}, sent you a friend request on #{item[1]} "
        else
          _text = "#{_user.first_name}  #{_user.last_name} became your friend on #{item[1]} "
        end

      else
        _like = Like.find(item[0])
        _user = User.find(_like.user_id)
        _photo = Photo.find(_like.photo_id)
        _text = "#{_user.first_name}  #{_user.last_name}, liked your picture #{_photo.photo_file_name} on   #{item[1]} "
      end
      _user_feed[_index]= _text
      _index = _index +1
      
    end

    @_user_feed ||= _user_feed
    
  end
  
  helper_method :user_requests
  private
  def user_requests
    items = ActiveRecord::Base.connection.execute("
      SELECT id_two,modification_date FROM friends WHERE id_one = #{current_user.id} AND relationship =0
      ORDER BY modification_date DESC")
    _user_requests = Array.new(items.size ,Hash.new)
    _index =0

    items.each  do |item|
      #get text

      _user = User.find(item[0])
      _text = "#{_user.first_name}  #{_user.last_name}, sent you a friend request on #{item[1]} "
      
      _user_requests[_index]['text']= _text
      _user_requests[_index]['friend_id']= _user.id
      _index = _index +1

    end

    @_user_requests ||= _user_requests
  end
end

