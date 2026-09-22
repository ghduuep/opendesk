require "test_helper"

class KnowledgeBase::CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get knowledge_base_categories_index_url
    assert_response :success
  end
end
