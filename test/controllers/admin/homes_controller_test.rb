require 'test_helper'

class Admin::HomesControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get admin_homes_top_url
    assert_response :success
  end

  test "should get menu" do
    get admin_homes_menu_url
    assert_response :success
  end
end
