require 'test_helper'

class PhotosControllerTest < ActionController::TestCase
  test "should get index" do
    session[:user_id] = 1
    get :index
    assert_response :success
  end
end
