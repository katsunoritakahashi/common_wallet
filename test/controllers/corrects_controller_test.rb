require "test_helper"

class CorrectsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get corrects_index_url
    assert_response :success
  end

  test "should get create" do
    get corrects_create_url
    assert_response :success
  end

  test "should get destroy" do
    get corrects_destroy_url
    assert_response :success
  end
end
