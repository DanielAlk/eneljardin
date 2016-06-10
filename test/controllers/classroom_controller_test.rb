require 'test_helper'

class ClassroomControllerTest < ActionController::TestCase
  test "should get videos" do
    get :videos
    assert_response :success
  end

  test "should get video" do
    get :video
    assert_response :success
  end

  test "should get notes" do
    get :notes
    assert_response :success
  end

end
