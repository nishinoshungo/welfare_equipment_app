require 'test_helper'

class Public::FavoriteItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_favorite_items_index_url
    assert_response :success
  end

  test "should get create" do
    get public_favorite_items_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_favorite_items_destroy_url
    assert_response :success
  end

end
