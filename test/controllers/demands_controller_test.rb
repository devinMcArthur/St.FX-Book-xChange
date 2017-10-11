require 'test_helper'

class DemandsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get demands_create_url
    assert_response :success
  end

  test "should get destroy" do
    get demands_destroy_url
    assert_response :success
  end

  test "should get show" do
    get demands_show_url
    assert_response :success
  end

end
