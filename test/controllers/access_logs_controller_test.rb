require "test_helper"

class AccessLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get access_logs_create_url
    assert_response :success
  end
end
