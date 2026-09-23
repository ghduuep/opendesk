class Agent::KnowledgeBase::ArticlesController < Agent::BaseController
  before_action :set_category, only: %i[new create]
  before_action :set_article, only: %i[show edit update]

  def show
  end

  def new
    @article = @category.articles.new
  end

  def create
    @article = @category.articles.new(article_params)

    if @article.save
      redirect_to agent_knowledge_base_category_path(@category), notice: "Article created succesfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
      redirect_to agent_knowledge_base_article_path(@article),
      notice: "Article update successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Current.account.knowledge_base_categories.find_by!(slug: params[:category_slug])
  end

  def set_article
    @article = KnowledgeBase::Article.joins(:category).where(knowledge_base_categories: { account_id: Current.account.id }).find_by!(slug: params[:slug])
  end

  def article_params
    params.require(:knowledge_base_article).permit(
      :title,
      :body,
      :status
    )
  end
end
