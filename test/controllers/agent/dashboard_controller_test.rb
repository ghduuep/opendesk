require "test_helper"

class Agent::DashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get agent_dashboard_index_url
    assert_response :success
  end
end
