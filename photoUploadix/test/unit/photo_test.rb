require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def test_new_photo
    photo = Photo.new
    assert photo.invalid?
    #only description needs to be tested
    assert photo.errors[:description].any?
  end
  def new_photo_from_name(photo_file_name)    
    Photo.new({"description" => "A test","photo_file_name" => photo_file_name,"is_private"=>false,"photo_content_type"=>"image/jpeg","photo_updated_at"=>"22/22/2222"})
    #photo.photo_file_size = 58915
  end

  def new_photo_from_user(user_id)
    u=User.new({"first_name" => "aa", "last_name"=>"last","email" => "ee@2.com","password"=>"eee"})
    u.save
    Photo.new({"description" => "A test","photo_file_name" => "eee.jpg","is_private"=>false,"photo_content_type"=>"image/jpeg","photo_updated_at"=>"22/22/2222","user_id"=>user_id})

    #photo.photo_file_size = 58915
  end

  def new_photo_from_content_type(content_type)
    
    Photo.new({"description" => "A test","photo_file_name" => content_type,"is_private"=>false,"photo_content_type"=>"image/jpeg","photo_updated_at"=>"22/22/2222"})
  end

  def new_photo_from_file_size(file_size)

    Photo.new({"description" => "A test","photo_file_name" => "image/jpeg","is_private"=>false,"photo_content_type"=>"image/jpeg","photo_updated_at"=>"22/22/2222","photo_file_size"=>file_size})
  end

  test "photo_file_name" do
    puts "\n\nTest extension checking \n\n"
    ok= %w{home-page.png home-page.jpeg home-page.gif home-page.pjpeg home-page.bmp}
    bad = %w{home-page.doc home-page.zip home-page.mpeg home-page.mp4 home-page.avi}

    ok.each do |photo_file_name |
      photo = new_photo_from_name(photo_file_name)
      assert photo.valid? puts "#{photo_file_name} shouldn't be invalid"
    end

    bad.each do |photo_file_name |
      photo = new_photo_from_name(photo_file_name)
      assert photo.invalid? puts "#{photo_file_name} shouldn't be valid"
    end

  end


  test "photo_content_type" do
    puts "\n\nTest content type checking \n\n"
    ok= %w{image/png image/zip}
    bad = %w{application/zip application/ms-word application/vnd.xls}

    ok.each do |photo_content_type |
      photo = new_photo_from_content_type(photo_content_type)
      assert photo.valid? puts "#{photo_content_type} shouldn't be invalid"

    end

    bad.each do |photo_content_type |
      photo= new_photo_from_content_type(photo_content_type)
      assert photo.invalid? puts "#{photo_content_type} shouldn't be valid"
    end

  end

   test "photo_file_size" do
    puts "\n\nTest file size  checking \n\n"
    ok= %w{4mb 3mb 2mb}
    bad = %w{6mb}

    ok.each do |photo_file_size |
      photo = new_photo_from_file_size(photo_file_size)
      assert photo.valid? puts "#{photo_file_size} shouldn't be invalid"

    end

    bad.each do |photo_file_size |
      photo= new_photo_from_file_size(photo_file_size)
      assert photo.invalid? puts "#{photo_file_size} shouldn't be valid"
    end

  end

  test "user_id" do
    puts "\n\nTest user_id constraint \n\n"
    ok= %w{1}
    bad = %w{2 3}

    ok.each do |user_id |
      photo = new_photo_from_user(user_id)
      assert photo.valid? puts "#{user_id} shouldn't be invalid"

    end

    bad.each do |user_id |
      photo= new_photo_from_user(user_id)
      assert photo.invalid? puts "#{user_id} shouldn't be valid"
    end

  end


end
