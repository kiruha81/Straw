require "test_helper"

class Public::ShopsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_shops_index_url
    assert_response :success
  end

  test "should get show" do
    get public_shops_show_url
    assert_response :success
  end

  test "should get new" do
    get public_shops_new_url
    assert_response :success
  end

  test "should get create" do
    get public_shops_create_url
    assert_response :success
  end

  test "should get edit" do
    get public_shops_edit_url
    assert_response :success
  end

  test "should get update" do
    get public_shops_update_url
    assert_response :success
  end
end
