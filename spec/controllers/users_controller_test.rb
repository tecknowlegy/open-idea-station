require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get signup" do
    get user_signup_url
    assert_response :success
  end

  test "should get login" do
    get user_login_url
    assert_response :success
  end

  test "should get edit_profile" do
    get user_edit_profile_url
    assert_response :success
  end
end
