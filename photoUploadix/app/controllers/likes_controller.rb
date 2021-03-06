class LikesController < ApplicationController
  def display_like_button
     likes = Like.where("photo_id=?",params[:cur_photo_id]).count
     user_like = Like.where("photo_id=? AND user_id=?",params[:cur_photo_id],current_user.id).count
     if user_like == 0

       like_status = "Like this picture"
     else
       like_status = "Unlike this picture"
     end
     render :text => "<span class='add-on' ><i class='icon-briefcase'></i></span>&nbsp;#{like_status}&nbsp;&nbsp;#{likes} likes  "
  end

  def update_likes
    user_like = Like.where("photo_id=? AND user_id=?",params[:cur_photo_id],current_user.id).limit(1)
    if user_like.length >0
      #if line delete the line .first..
      Like.delete(user_like[0].id.to_s)
    else
      #if no line add a line
      like = Like.new
      like.user_id = current_user.id
      like.photo_id = params[:cur_photo_id]
      like.modification_date = Time.now.getutc
      like.save
    end
    
    render :text => "OK"
    

    
  end
end