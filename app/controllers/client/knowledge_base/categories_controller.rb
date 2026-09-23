class Client::KnowledgeBase::CategoriesController < Client::BaseController
  before_action :set_category, only: :show

  def index
    @categories = Current.account.knowledge_base_categories.order(:name)
  end

  def show
    @articles = @category.articles.published.order(:title)
  end

  private

  def set_category
    @category = Current.account.knowledge_base_categories.find_by!(slug: params[:slug])
  end
end
