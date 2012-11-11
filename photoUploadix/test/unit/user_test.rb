require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_new_user
    user = User.new
    assert user.invalid? puts "user should be invalid"
    assert user.errors[:first_name].any?
    assert user.errors[:last_name].any?
    assert user.errors[:email].any?
    assert user.errors[:password].any?
  end

  def user_from_email(email)
    User.new({"id" =>1, "first_name" => "aa", "last_name"=>"last","email" => email,"password"=>"eee","status"=>true,"registration_token"=>""})
  end


  test "user_email" do
    puts "\n\nTest user_email checking \n\n"
    ok= %w{arnaud@hotmail.com ee.ee@aa.com}
    bad = %w{ew ew.ewqwe /.ewq@.co2./}

    ok.each do |user_email |
      user = user_from_email(user_email)
      puts user.inspect
      if assert user.valid?
        puts "#{user_email} shouldn't be invalid"
      end
    end

    bad.each do |user_email |
      user = user_from_email(user_email)
      assert user.invalid? puts "#{user_email} shouldn't be valid"
    end

  end


end