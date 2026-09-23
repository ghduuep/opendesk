class Client::KnowledgeBase::ArticlesController < Client::BaseController
  before_action :set_article

  def show
  end

  private

  def set_article
    @article = KnowledgeBase::Article.joins(:category).published.where(knowledge_base_categories: { account_id: Current.account.id }).find(params[:id])
  end
end
