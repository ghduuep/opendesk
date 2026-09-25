class Client::KnowledgeBase::ArticlesController < Client::BaseController
  before_action :set_article, only: :show

  def index
    customer_articles.search(params[:q])
  end

  def show
  end

  private

  def customer_articles
    KnowledgeBase::Article.joins(:category).published.where(knowledge_base_categories: { account_id: Current.account.id })
  end

  def set_article
    @article = customer_articles.find_by!(slug: params[:slug])
  end
end
