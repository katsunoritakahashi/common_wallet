require "test_helper"

class DepositsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get deposits_index_url
    assert_response :success
  end

  test "should get crete" do
    get deposits_crete_url
    assert_response :success
  end

  test "should get destroy" do
    get deposits_destroy_url
    assert_response :success
  end
end
