require 'test_helper'
class StaticpageControllerTest < ActionController::TestCase
test "should get home" do
    get :home
    assert_response :success
    assert_select "title", "Venshop of Trang"
  end

  test "should get help" do
    get :help
    assert_response :success
    assert_select "title", "Help | Help for Venshop of Trang "
  end
end