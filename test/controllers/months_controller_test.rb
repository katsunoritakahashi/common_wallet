require "test_helper"

class MonthsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get months_index_url
    assert_response :success
  end

  test "should get new" do
    get months_new_url
    assert_response :success
  end

  test "should get create" do
    get months_create_url
    assert_response :success
  end

  test "should get destroy" do
    get months_destroy_url
    assert_response :success
  end

  test "should get show" do
    get months_show_url
    assert_response :success
  end
end
