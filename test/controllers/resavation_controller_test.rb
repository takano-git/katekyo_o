require 'test_helper'

class ResavationControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get resavation_create_url
    assert_response :success
  end

end
